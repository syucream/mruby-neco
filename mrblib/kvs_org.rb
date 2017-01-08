module Neco
  class KvsOrg
    include Enumerable
 
    def initialize
      @dbs = Hash.new
    end

    def close
      @dbs.each_value do |db|
        db.close
      end
    end

    def each_for(target, &block)
      sym = to_sym(target)
      @dbs[sym].each block
    end

    def each(&block)
      @dbs.each_value do |db|
        db.each block
      end
    end

    #
    # Member controllers
    #
    def add_member(target, params)
      sym = to_sym(target)
      db = get_adapter(sym, params)
      @dbs[sym] = db
    end

    def del_member(target)
      sym = to_sym(target)
      @dbs[sym].close
      @dbs.delete sym
    end

    def members
      @dbs.map do |sym, db|
        sym
      end
    end

    #
    # Getters
    #
    def get_from(target, key)
      sym = to_sym(target)
      @dbs[sym].get key
    end

    def get_from_all(key)
      values = Hash.new
      @dbs.each_pair do |sym, db|
        values[sym] = db.get key
      end

      values
    end

    #
    # Setters
    #
    def put_to(target, key, value)
      sym = to_sym(target)
      @dbs[sym].put key, value
    end

    def put_to_all(key, value)
      @dbs.each_value do |db|
        db.put key, value
      end
    end

    #
    # Deleters
    #
    def delete_from(target, key)
      sym = to_sym(target)
      @dbs[sym].delete key
    end

    def delete_from_all(key)
      @dbs.each_value do |db|
        db.delete key
      end
    end

    private

    def to_sym(target)
      return target if target.is_a?(Symbol)

      case target
      when 'etcd', 'Etcd'
        :etcd
      when 'lmdb', 'Lmdb', 'LMDB'
        :lmdb
      when 'redis', 'Redis'
        :redis
      end
    end

    def get_adapter(dbsym, params)
      case dbsym
      when :etcd
        klass = Adapter::EtcdKvs
      when :lmdb
        klass = Adapter::LmdbKvs
      when :redis
        klass = Adapter::RedisKvs
      end

      case klass.open_type
      when Adapter::OPEN_AS_FILE
        path = params[:path]

        options = params[:options]
        klass.new(path, options)
      when Adapter::OPEN_AS_SOCK
        host = params[:host]
        port = params[:port]

        options = params[:options]
        klass.new(host, port, options)
      when Adapter::OPEN_AS_HTTP
        url = params[:url]

        klass.new(url)
      end
    end
  end
end
