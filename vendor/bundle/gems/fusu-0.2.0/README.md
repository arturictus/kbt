# Fusu (Functional Support)

This gems intends to add all the convinient methods and helpers from ActiveSupport in a functional way.

why?

I love the easy a convinient methods `ActiveSupport` adds to ruby.
I do not like to build gems that depend in a current version of `ActiveSupport` that could mean this gems will not be able to work with different `Rails` versions.
As well the overriding aproach of `ActiveSupport` could get messy in big projects and harder to maintain, the functional aproach it's easier to keep dependencies and `class` overridings.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fusu'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fusu

## Usage

### blank?

```ruby
Fusu.blank?(nil) #=> true
Fusu.blank?('') #=> true
Fusu.blank?('fusu') #=> false
Fusu.blank?([]) #=> true
Fusu.blank?([1]) #=> false
# etc ...
```

### Array

#### wrap
```ruby
Fusu::Array.wrap(nil) # => []
Fusu::Array.wrap([]) # => []
Fusu::Array.wrap([1]) # => [1]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

Fork from github and make a pull request.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/arturictus/fusu. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
