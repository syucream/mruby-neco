module Neco
  module Adapter
    class K2HashKvs
      include Enumerable

      def self.open_type
        OPEN_AS_FILE
      end

      def initialize(path, options)
        @db = K2Hash.new(path, options[:mode], options[:flags])
      end

      def get(key)
        @db.fetch key
      end

      def put(key, value)
        @db.store key, value
      end

      def delete(key)
        @db.delele key
      end

      def each(block)
        @db.each do |key, value|
          block.call key, value
        end
      end

      def close
        @db.close
      end
    end
  end
end
