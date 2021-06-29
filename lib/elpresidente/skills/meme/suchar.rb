module Elpresidente
  module Skills
    module Meme
      class Suchar < Skill
        use ::Meme::Suchar, as: :random_suchar

        def execute
          return unless mentioned? || personal?
          return unless match?(/suchar/i)

          info 'Fetching suchar...'
          typing!
          suchar = random_suchar(internet: internet)
          info "Got: #{suchar}"

          say!(suchar[:text])

          if suchar[:punchline]
            task.async do |punchline|
              ['five', 'four', 'three', 'two', 'one'].each do |num|
                typing!
                punchline.sleep 1
                say!(":#{num}:")
              end
              say!(suchar[:punchline])
            end
          end

          stop!
        end
      end
    end
  end
end