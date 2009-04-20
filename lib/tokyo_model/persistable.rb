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
        instance_methods.select {|m| m =~ /[^=]$/ && instance_methods.include?("#{m}=") && !%w(taguri).include?(m) }
      end
      
      def find(&block)
        ids = query.conditions(&block).execute
        ids.inject([]) { |m, o| m << get(o); m }
      end
      
      def query
        Query.new(db).conditions { type_is "Post" }
      end

    end

    def ==(obj)
      self.class == obj.class && id == obj.id
    end

    def attributes
      self.class.setter_methods.inject({}) { |m, o|
        v = send(o.to_sym)
        m[o] = v if v
        m
      }
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