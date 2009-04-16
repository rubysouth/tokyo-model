module TokyoModel
  
  module Persistable
    
    def self.included(base)
      base.class_eval { extend TokyoModel::Persistable::ClassMethods }
    end
    
    module ClassMethods
      
      def  connect(uri)
        @db = TokyoModel::Database.open(uri)
      end

      def db
        @db ||= TokyoModel::DATABASES.first
      end
    
      def get(id)
        obj = new
        if record = db.get(id)
          record.each { |k, v| obj.send("#{k}=".to_sym, v) }
          obj.id = id
        end
        obj
      end
      alias_method :find, :get

      def setter_methods
        instance_methods.select {|m| m =~ /[^=]$/ && instance_methods.include?("#{m}=") && !%w(taguri).include?(m) }
      end
      
    end
    
    def ==(obj)
      self.class == obj.class && id == obj.id 
    end

    def attributes
      self.class.setter_methods.inject({}) do |m, o| 
        v = send(o.to_sym)
        m[o] = v if v
        m
      end
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
      db.put(id, attributes)
    end
    alias_method :save, :put
  
  end
end