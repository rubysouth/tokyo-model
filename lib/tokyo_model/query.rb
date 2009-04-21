module TokyoModel

  class Query

    attr :conditions, :db_query

    # Query condition: string is equal to
    QCSTREQ   = 1
    # Query condition: string is included in
    QCSTRINC  = 2
    # Query condition: string begins with
    QCSTRBW   = 3
    # Query condition: string ends with
    QCSTREW   = 4
    # Query condition: string includes all tokens in
    QCSTRAND  = 5
    # Query condition: string includes at least one token in
    QCSTROR   = 6
    # Query condition: string is equal to at least one token in
    QCSTROREQ = 7
    # Query condition: string matches regular expressions of
    QCSTRRX   = 8
    # Query condition: number is equal to
    QCNUMEQ   = 9
    # Query condition: number is greater than
    QCNUMGT   = 10
    # Query condition: number is greater than or equal to
    QCNUMGE   = 11
    # Query condition: number is less than
    QCNUMLT   = 12
    # Query condition: number is less than or equal to
    QCNUMLE   = 13
    # Query condition: number is between two tokens of
    QCNUMBT   = 14
    # Query condition: number is equal to at least one token in
    QCNUMOREQ = 15
    # Query condition: negation flag
    QCNEGATE  = 1 << 24
    # Query condition: no index flag
    QCNOIDX   = 1 << 25
    # Order type: string ascending
    QOSTRASC  = 1
    # Order type: string descending
    QOSTRDESC = 2
    # Order type: number ascending
    QONUMASC  = 3
    # Order type: number descending
    QONUMDESC = 4
    # Post treatment: modify the record
    QPPUT     = 1 << 0
    # Post treatment: remove the record
    QPOUT     = 1 << 1
    # Post treatment: stop the iteration
    QPSTOP    = 1 << 24

    def initialize(db_query)
      @db_query = db_query
      @conditions = []
    end

    def conditions(&block)
      @conditions += QueryConditions.new.instance_eval(&block)
      self
    end

    def execute
      @conditions.each { |c| @db_query.addcond(*c) }
      @db_query.search
    end

    CONDITIONS = {
      :is          => QCSTREQ,
      :like        => QCSTRINC,
      :has         => QCSTROR,
      :has_all     => QCSTRAND,
      :equals_one  => QCSTROREQ,
      :begins_with => QCSTRBW,
      :ends_with   => QCSTREW,
      :matches     => QCSTRRX,
      :eq          => QCNUMEQ,
      :gt          => QCNUMGT,
      :gte         => QCNUMGE,
      :lt          => QCNUMLT,
      :lte         => QCNUMLE,
      :btw         => QCNUMBT,
      :in          => QCNUMOREQ
    }
  end

  class QueryConditions

    attr :conditions

    METHODS = Query::CONDITIONS.keys.inject([]) { |m, o| m << o.to_s }.join("|")

    def initialize
      @conditions = []
    end

    def method_missing(symbol, *args)
      symbol.to_s =~ /([a-z0-9_]+)_(#{METHODS}+)(!)?/
      name, op, negate = $1, $2.to_sym, $3
      op = negate ? Query::QCNEGATE | Query::CONDITIONS[op] : Query::CONDITIONS[op]
      conditions << [name, op] + args
    end

  end

end