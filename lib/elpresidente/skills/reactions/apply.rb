module Elpresidente
  module Skills
    module Reactions
      class Apply < Skill
        def execute
          reactions = blackboard.user.items('reactions')
          return if reactions.empty?

          reactions.each { |emoji| react!(emoji) }

          continue!
        rescue Slack::Web::Api::Errors::MessageNotFound
          skip!
        end
      end
    end
  end
end