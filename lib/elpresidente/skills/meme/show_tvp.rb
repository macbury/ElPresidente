module Elpresidente
  module Skills
    module Meme
      class ShowTvp < Skill
        use ::Meme::Tvp, as: :generate_meme

        def execute
          return unless mentioned? || personal?

          case match?(/tvp (?<pasek>.+){0,48}$/i)
          in { pasek: }
            typing!
            image_url = generate_meme(internet: internet, message: pasek)

            say!(image_url) do |block|
              block.image url: image_url, alt_text: pasek
            end

            stop!
          else
            skip!
          end
        rescue Async::HTTP::Protocol::RequestFailed
          react!('boom')
          stop!
        end
      end
    end
  end
end