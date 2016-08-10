# Heelbot

[![Join the chat at https://gitter.im/crispgm/heelbot](https://badges.gitter.im/crispgm/heelbot.svg)](https://gitter.im/crispgm/heelbot?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
![](https://img.shields.io/badge/license-MIT-blue.svg)
[![Code Climate](https://codeclimate.com/github/crispgm/heelbot/badges/gpa.svg)](https://codeclimate.com/github/crispgm/heelbot)
![](https://api.travis-ci.org/crispgm/heelbot.svg)

## Introduction

Heelbot helps us enable work automation, by providing a minimal Ruby framework to build awesome bots. We believe that every duplicated work can be done automatically.

## Installation

```
git clone https://github.com/crispgm/heelbot.git

cd heelbot

bundle install

bundle exec bin/heel --version
```

## Usage

```
# List All Bots
bundle exec bin/heel bot list

# Help of Bot
bundle exec bin/heel help BOT_NAME

# Run Bot
bundle exec bin/heel run BOT_NAME
```

## In-house Bots

* Group Members
* Mail Template
* iCiba Online Dictionary
* Air Quality Index
* Hello World (Sample Bot)
* Eurocup 2016 Schedule (deprecated)
* Eurocup 2016 Results (deprecated)

## Build Bots

1. Create a file in ```./heelspec```, e.g. ```hello_world.rb```

    ```
    module Heelspec
      class HelloWorld < Heel::Bot
        def initialize
          @bot_name     = "Hello World"
          @bot_version  = "1.0.0"
          @bot_summary  = "Print Hello World"
          @bot_author   = "David Zhang"
          @bot_license  = "MIT"
          @bot_helptext = ""
        end

        def run(cmd)
          @msg = get_param(cmd, 0)
          puts @msg
        end
      end
    end
    ```

2. Add your bot to ```bots.yml```

    ```
    - Name: hello_world
      Ver: 1.0.0
    ```

3. Run the bot

    ```
    bundle exec bin/heel run hello_world "hello, world"
    ```

    The result is:

    ```
    hello, world
    ```