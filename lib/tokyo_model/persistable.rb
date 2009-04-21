module TokyoModel

  module Persistable

    def self.included(base)
      base.class_eval { extend TokyoModel::Persistable::ClassMethods }
    end

    module ClassMethods

      def  db=(*args)
        db_or_uri = args.shift
        if db_or_uri.respond_to?(:scheme)
          @db = TokyoModel.open(db_or_uri, *args)
        else
          @db = db_or_uri
        end
      end

      def db
        @db ||= TokyoModel::DATABASES.first
      end

      def get(id)
        obj = new
        if record = db.get(id)
          record.each { |k, v| obj.send("#{k}=".to_sym, v) if obj.respond_to?("#{k}=".to_sym) }
          obj.id = id
        end
        obj
      end
      alias_method :find, :get

      def setter_methods
        if !@setter_methods
          im = instance_methods - Object.instance_methods
          @setter_methods = im.select {|m| im.include?("#{m}=") && m =~ /[^=]$/ }
        end
        @setter_methods
      end

      def find(&block)
        ids = query.conditions(&block).execute
        ids.inject([]) { |m, o| m << get(o); m }
      end

      def query
        type = self.to_s
        db.query.conditions { type_is type }
      end

    end

    def ==(obj)
      self.class == obj.class && id == obj.id
    end

    def attributes
      hash = {}
      self.class.setter_methods.each do |s|
        val = send(s.to_sym)
        hash[s] = val if val
      end
      hash
    end

    def db
      self.class.db
    end

    def id
      @id ||= db.genuid
    end

    def id=(id)
      @id = id
    end

    def put
      db.put(id, attributes.merge({ "type" => self.class.to_s }))
    end
    alias_method :save, :put

  end
end