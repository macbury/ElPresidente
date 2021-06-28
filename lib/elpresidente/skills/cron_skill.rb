module Elpresidente
  module Skills
    class CronSkill < Skill
      private

      def cron_match?(cron_rule)
        Fugit::Cron.parse(cron_rule).match?(execution_time)
      end

      def execution_time
        data[:execution_time].beginning_of_minute
      end

      def channel_id
        client.web_client.channels_id(channel: channel_name).dig('channel', 'id')
      end

      def channel_name
        raise NotImplementedError, 'Implement channel name'
      end
    end
  end
end