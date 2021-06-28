require 'slack-ruby-block-kit'

module Elpresidente
  module Skills
    class Base
      extend Usable

      BOT_NAME_REGEXP = /elpresidente/i
      attr_reader :result

      def initialize(options)
        @client = options[:client]
        @data = options[:data]
        @blackboard = options[:blackboard]
        @task = options[:task]
        @internet = options[:internet]
        @result = :skip
      end

      def self.execute(...)
        skill = self.new(...)
        skill.execute
        skill.result
      end

      def execute
        raise 'Not Implemented'
      end

      def to_h
        {
          client: client,
          data: data,
          blackboard: blackboard,
          task: task,
          internet: internet
        }
      end

      private

      attr_reader :barrier, :client, :data, :blackboard, :task, :internet

      # Run each skill until any of it returns :stop
      def sequence(skills)
        skills.each do |skill_class|          
          @result = skill_class.execute(self)
  
          if @result == :continue
            Async.logger.info "Executed: #{skill_class}, continue."
          elsif result == :stop
            Async.logger.info "Executed: #{skill_class}, stop."
          end

          next if @result == :continue || @result == :skip
          break if @result == :stop

          raise "Please end your execute method with stop! or continue!"
        end
        @result
      end

      def barrier
        @barrier ||= Async::Barrier.new
      end

      # Current message sent by user
      def message
        data['text']
      end

      def channel_id
        data['channel']
      end

      def channel
        client.channels[channel_id]
      end

      def thread_id
        data['ts']
      end

      def author_id
        data['user']
      end

      def author
        client.users[author_id]
      end

      # Check if current message content matches passed regexp
      def match?(regexp)
        message&.match(regexp)&.named_captures&.symbolize_keys
      end

      def typing!
        client.typing channel: channel_id
      end

      # Add emoji to current message
      def react!(emoji)
        client.web_client.reactions_add channel: channel_id, timestamp: thread_id, name: emoji
      rescue Slack::Web::Api::Errors::MessageNotFound
      end

      # Reply to user thread
      def reply!(message, channel: nil, &block)
        blocks = block ? Slack::BlockKit.blocks(&block).as_json : []

        client.web_client.chat_postMessage(channel: channel_id, text: message, blocks: blocks, thread_ts: thread_id)
      end

      # Send message on current channel
      def say!(message, &block)
        blocks = block ? Slack::BlockKit.blocks(&block).as_json : []

        client.web_client.chat_postMessage(channel: channel_id, text: message, blocks: blocks)
      end

      # List of users that are mentioned in current message
      def mentions
        @mentions ||= data&.fetch('blocks', nil)&.flat_map { |block| block['elements'] }
                                                &.compact
                                                &.flat_map { |block| block['elements'] }
                                                &.map { |type| client.users[type[:user_id]] }
                                                &.compact || []
      end

      # Is current bot mentioned in message
      def mentioned?
        mentions.map { |u| u[:name] }.any? { |name| name.match(BOT_NAME_REGEXP) }
      end

      def admin?
        blackboard.member_exists?('admins', author_id)
      end

      # Is this direct message to bot application
      def personal?
        client.ims[channel_id]&.user == author_id
      end

      # Stops processing current sequence, no other skills will be processed
      def stop!
        @result = :stop
      end

      # Continue processing current sequence with success
      def continue!
        @result = :continue
      end

      # Continue processing current sequence, this is default reaction after execute
      def skip!
        @result = :skip
      end

      def info(msg)
        Async.logger.info "[#{self.class.name}] #{msg}"
        nil
      end
    
      def error(msg)
        Async.logger.error "[#{self.class.name}] #{msg}"
        nil
      end
    end
  end
end