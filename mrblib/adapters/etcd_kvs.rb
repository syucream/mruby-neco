module Neco
  module Adapter
    class EtcdKvs
      include Enumerable

      def self.open_type
        OPEN_AS_HTTP
      end

      def initialize(url)
        @db = Etcd::Client.new(url)
      end

      def get(key)
        @db.get key
      end

      def put(key, value)
        @db.put key, value
      end

      def delete(key)
        @db.delete key
      end

      def each(block)
        list = @db.list ''
        list.each do |hash|
          key = hash['key'].slice(1..-1) # remove heading '/'
          value = hash['value']
          block.call(key, value)
        end
      end

      def close
        # NOP
      end
    end
  end
end
