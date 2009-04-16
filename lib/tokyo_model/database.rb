module TokyoModel
  
  DATABASES = []
  
  class Database
    
    class << self

      # TODO suport all open modes and options
      # TODO support tyrant connections
      def open(uri)
        puri = URI::parse(uri)
        path = puri.path
        db = TokyoCabinet::TDB::new
        db.open(path, TokyoCabinet::TDB::OWRITER | TokyoCabinet::TDB::OREADER)
        TokyoModel::DATABASES << db
        db
      end

      # TODO support tyrant
      # TODO support all create options
      def create(uri)
        puri = URI::parse(uri)
        path = puri.path
        raise CreateError.new("Database already exists at #{uri}") if File.exists? path
        db = TokyoCabinet::TDB::new
        db.open(path, TokyoCabinet::TDB::OWRITER | TokyoCabinet::TDB::OCREAT)
        db.close
      end
    
    end
    
  end

  class CreateError < StandardError ; end

end
