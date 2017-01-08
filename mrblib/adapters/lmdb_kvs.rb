module Neco
  module Adapter
    class LmdbKvs
      include Enumerable

      def self.open_type
        OPEN_AS_FILE
      end

      def initialize(path, options)
        args = [path]
        if options && options.has_key?(:flags)
          args.push(options[:flags])
          args.push(options[:mode]) if options.has_key?(:mode)
        end
        env = MDB::Env.new
        env.open(*args)
        @db = env.database
      end

      def get(key)
        @db.fetch key
      end

      def put(key, value)
        @db[key] = value
      end

      def delete(key)
        @db.del(key)
      end

      def each(block)
        @db.each do |key, value|
          block.call key, value
        end
      end

      def close
        # NOP
      end
    end
  end
end
