# ElPresidente

Super simple slack bot

## Used tech

* `redis` - for persisting information
* `ruby` - sane language
* `async` - ruby library for doing async stuff

## Project Structure

* `exe/elpresidente` - this is where bot starts
* `fortunes/` - list of funny fortunes used by elpresidente
* `lib/elpresidente/skills/` - skills used by bot, skill can interact with message, respond to it or just ignore it 
* `lib/elpresidente/services/` - list of helpers/services used by skills
* `spec` - if somebody is really bored, he can add specs here

## What is a skill?

Skill is just a simple class that checks if it should run for specified slack event. After running it can decide if processing of the slack event should be stopped or proceeded.

## How to add skill?

Lets say that we want simple skill that replies with `yolo` to each message in slack. Create skill file `lib/elpresidente/skills/respond_with_yolo.rb`:

```ruby
module Elpresidente
  module Skills
    class RespondWithYolo < Skill
      def execute
        reply! "Yolo" # reply to all events with yolo
        continue! # allow other skills to execute
      end
    end
  end
end

```

Now register it in `lib/elpresidente/start.rb`. This is first skill that runs all other skills:

```ruby
module Elpresidente
  module Skills
    # Main skill that tries to find skill to execute
    class Start < Base
      ...

      def execute
        sequence [
          ...
          RespondWithYolo, # <= always add new skills before Gentlemen::AskWhatYouWant
          Gentlemen::AskWhatYouWant,
        ]
        ...
      end
    end
  end
end
```

And now you can start bot:

```
exe/elpresidente start -c 1 -d
```

Adding `-d` flag starts development mode with enabled reloading of code(you don't need to restart app, when you make changes to your skill classes). 

## Setup

Add first admin

```
redis-cli
lpush admins slack_user_id
```

## Development

```
bundle install
docker-compose up
exe/elpresidente start -c 1 -d
```

## Test deployment
```
docker-compose --project-name elpresidente_local --file docker-compose.local.yml up
```

## Deployment

```
docker-compose --project-name elpresidente_production --file docker-compose.production.yml up
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## References

* https://github.com/socketry/async
* https://github.com/slack-ruby/slack-ruby-client
* https://github.com/CGA1123/slack-ruby-block-kit
* https://github.com/kevingnet/fortunes_translated


