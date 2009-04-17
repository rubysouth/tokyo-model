require 'tokyotyrant'

module TokyoModel
  module Adapters

    # This adapter provides access to TokyoTyrant TDB databases.
    class Tyrant < AbstractAdapter

      DEFAULT_PORT = 1978

      # Open the TDB file. Accepts a URI and discards any extra arguments
      # passed in.
      #
      #   db = TokyoModel::Adapters::Tyrant.new("tyrant://localhost:1978")
      #   db = TokyoModel::Adapters::Tyrant.new("unix://host/var/sock/tyrant.sock")
      def initialize(uri, *args)
        @db = TokyoTyrant::RDBTBL::new
        if uri.scheme == "unix"
          @db.open(uri.path, 0)
        else
          @db.open(uri.host, uri.port || DEFAULT_PORT)
        end
      end

    end
  end
end