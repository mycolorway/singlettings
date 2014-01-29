# Singlettings

A simple YML to singleton class solution for ruby programming language. It can be seamless integrated with Rails, Rack, sinatra and any other ruby apps.

It greatly inspired from [Yettings](https://github.com/charlotte-ruby/yettings).

## Installation

Add this line to your application's Gemfile:

    gem 'singlettings'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install singlettings

## Usage

### Convention Usage for Rails App.

- Create the yaml configuration file named 'singletting.yml' or 'yetting.yml' in 'config' directory. Then you can invoke it by calling ```Singletting.balh_blah_blah``` or ```Yetting.balh_blah_blah```

- Also you can put the configuration files in the 'config/singlettings' directory, the singleton classes will be mechanically generated as described above.

### Convention for other apps, such as rack & sinatra

- Place the configuration files anywhere you want. If the YAML file is named 'Setting', then:

  ```(ruby)
    class Setting < Singlettings::Base
      source "#{dir_to_config_file}"
      ns :your_namespace # Well, a bit clojure flavour...
    end
  ```

- Or Just in the lazy way, which will read the setting.yml file in the root directory:
  ```(ruby)
    class Setting < Singlettings::Base
    end
  ```

- Last but not least, you can use it as an global variable by calling:
  ```(ruby)
    SETTING = Singlettings::Base.new("config/settings.yml", "development")
  ```

### Operations on the Singletting Object


You can invoke the object by calling as a hash:
  ```(ruby)
    Setting["key1"] # => value1
    Setting["key1"]["key2"] # => value2
    Setting[:key1][:key2][:key3] # => value3

    Setting.respond_to? :key1  # => true
    Setting.key1.respond_to? :key2 # => true

  ```

Also by calling:
  ```(ruby)
    Setting.key1 # => value1
    Setting.key1.key2 # => value2
  ```

### Testing

- It can be tested by running ```$ rake rspec```. You can debug it by calling ```$ rake console``` as well.

- A rails 4.0 app called 'myapp' is included in the repo to test compatibility.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
