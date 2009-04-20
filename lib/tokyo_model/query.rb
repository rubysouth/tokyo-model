module TokyoModel

  class Query

    attr :conditions, :db

    def initialize(db = nil)
      @db = db || TokyoModel::DATABASES.first
      @conditions = []
    end

    def conditions(&block)
      @conditions += QueryConditions.new.instance_eval(&block)
      self
    end
    
    def execute
      query = TokyoCabinet::TDBQRY::new(@db.connection)
      @conditions.each { |c| query.addcond(*c) }
      query.search
    end

    CONDITIONS = {
      :is          => TokyoCabinet::TDBQRY::QCSTREQ,    # string is equal to
      :like        => TokyoCabinet::TDBQRY::QCSTRINC,   # string is included in
      :has         => TokyoCabinet::TDBQRY::QCSTROR,    # string includes at least one tokens in
      :has_all     => TokyoCabinet::TDBQRY::QCSTRAND,   # string includes all tokens in
      :equals_one  => TokyoCabinet::TDBQRY::QCSTROREQ,  # string is equal to at least one token in
      :begins_with => TokyoCabinet::TDBQRY::QCSTRBW,    # string begins with
      :ends_with   => TokyoCabinet::TDBQRY::QCSTREW,    # strings ends with
      :matches     => TokyoCabinet::TDBQRY::QCSTRRX,    # string matches regexp
      :eq          => TokyoCabinet::TDBQRY::QCNUMEQ,    # number is equal to
      :gt          => TokyoCabinet::TDBQRY::QCNUMGT,    # number is greater than
      :gte         => TokyoCabinet::TDBQRY::QCNUMGE,    # number is great than or equal to
      :lt          => TokyoCabinet::TDBQRY::QCNUMLT,    # number is less than
      :lte         => TokyoCabinet::TDBQRY::QCNUMLE,    # number is less than or equal to
      :btw         => TokyoCabinet::TDBQRY::QCNUMBT,    # number is number is between two tokens of
      :in          => TokyoCabinet::TDBQRY::QCNUMOREQ,  # number is equal to at least one token in
    }
  end

  class QueryConditions

    attr :conditions

    METHODS = Query::CONDITIONS.keys.inject([]) { |m, o| m << o.to_s }.join("|")

    def initialize
      @conditions = []
    end

    def method_missing(symbol, *args)
      symbol.to_s =~ /([a-z0-9_]*)_(#{METHODS}+)(!)?/
      name, op, negate = $1, $2, $3
      op = negate ? TokyoCabinet::TDBQRY::QCNEGATE | Query::CONDITIONS[op.to_sym] : Query::CONDITIONS[op.to_sym]
      conditions << [name, op] + args
    end

  end

end