module TokyoModel
  module Adapters

    # This adapter provides access to TokyoCabinet TDB files.
    class File < AbstractAdapter


      # Permitted open modes for accessing TDB files: +:read+, +:write+,
      # +:create+, +:truncate+, +:nolock+, +:lock_noblock+ and +:sync+
      OPEN_MODES = {
        :read         => TokyoCabinet::TDB::OREADER,
        :write        => TokyoCabinet::TDB::OWRITER,
        :create       => TokyoCabinet::TDB::OCREAT,
        :truncate     => TokyoCabinet::TDB::OTRUNC,
        :nolock       => TokyoCabinet::TDB::ONOLCK,
        :lock_noblock => TokyoCabinet::TDB::OLCKNB,
        :sync         => TokyoCabinet::TDB::OTSYNC
      }.freeze

      # Open the TDB file. Accepts a URI and list of open modes:
      #
      #   db = TokyoModel::Adapters::File.new("file:///tmp/database.tdb", :read,
      #     :write, :create, :trunc)
      def initialize(uri, *args)
        @db = TokyoCabinet::TDB::new
        @db.open(uri.path, args.empty? ? File.default_open_mode : File.open_mode(*args))
      end

      class << self

        # The default open mode is read/write.
        def default_open_mode
          open_mode(:read, :write)
        end

        # Takes an array of open mode symbols and returns the mode number:
        #
        #   open_mode(:read, :write, :sync) # 3
        #   open_mode(:read, :write, :sync) # 67
        def open_mode(*modes)
          modes.inject(0) { |memo, obj| memo | OPEN_MODES[obj.to_sym].to_i }
        end

      end

    end
  end
end