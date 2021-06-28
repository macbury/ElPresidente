module Elpresidente
  module Blackboard
    class Base
      attr_reader :client, :namespace

      def initialize(client:, namespace: nil)
        @namespace = namespace
        @client = client
      end

      def set(key, value)
        client.set(build_key(key), value.to_yaml)
      end

      def get(key)
        client.get(build_key(key), YAML.load(value))
      end

      def member_exists?(key, value)
        client.call('lpos', build_key(key), value)
      end

      def push(key, value)
        client.lpush build_key(key), value unless member_exists?(key, value)
      end

      def items(key)
        client.lrange build_key(key), -100, 100
      end

      def remove(key, value)
        client.lrem build_key(key), 1, value
      end

      private

      def build_key(key)
        [namespace, key].join('/')
      end
    end
  end
end