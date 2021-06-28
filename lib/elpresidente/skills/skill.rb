module Elpresidente
  module Skills
    # Skill represents how bot should react to message
    class Skill < Base
      def initialize(parent)
        super(parent.to_h)
      end
    end
  end
end