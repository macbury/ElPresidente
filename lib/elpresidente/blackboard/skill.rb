module Elpresidente
  module Blackboard
    class Skill < Base
      def initialize(client:, data:)
        super(client: client, namespace: 'global')
        @data = data
      end

      def user
        @user ||= for_user(data['user'])
      end

      def for_user(user_id)
        Base.new(client: client, namespace: ['user', user_id].join('/'))
      end

      def channel
        @channel ||= Base.new(client: client, namespace: ['channel', data['channel']].join('/'))
      end

      def local
        @local ||= Base.new(client: client, namespace: ['channel', data['ts']].join('/'))
      end

      private

      attr_reader :data
    end
  end
end