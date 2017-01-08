module Neco
  module Adapter
    class RedisKvs
      include Enumerable

      def self.open_type
        OPEN_AS_SOCK
      end

      def initialize(host, port, options)
        if options && options.has_key?(:timeout)
          @db = Redis.new host, port, options[:timeout]
        else
          @db = Redis.new host, port
        end
      end

      def get(key)
        @db.get key
      end

      def put(key, value)
        @db.set key, value
      end

      def delete(key)
        @db.del key
      end

      def each(block)
        keys = @db.keys '*'
        keys.each do |key|
          value = self.get(key)
          block.call key, value
        end
      end

      def close
        @db.close
      end
    end
  end
end
