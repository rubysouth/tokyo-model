module TokyoModel
  module Adapters

    # This class exists almost exclusively to document the methods that all
    # adapters must implement. The default implementation simply delegates
    # everything to the underlying database file or connection.
    class AbstractAdapter

      attr :db
      
      def connection
        @db
      end

      # Delete the record identified by +pkey+.
      def out(pkey)
        @db.out(pkey)
      end
      alias_method :delete, :out

      # Generate a new primary key to use as an identifier for a new record.
      def genuid
        @db.genuid
      end

      # Fetch the record identified by +pkey+.
      def get(pkey)
        @db.get(pkey)
      end

      # Insert or update the record identified by +pkey+.
      def put(pkey, hash)
        @db.put(pkey, hash)
      end

      # Perform a query.
      def query
        Query.new(db)
      end

      # Delegate any unknown method calls to the underlying +@db+.
      def method_missing(symbol, *args)
        @db.send(symbol, *args)
      end

    end
  end
end