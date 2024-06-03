# Bp3::PaperTrail

bp3-railties adapts `paper_trail` for BP3, the persuavis/black_phoebe_3
multi-site multi-tenant rails application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bp3-paper_trail'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install bp3-paper_trail

## Usage

In your application's `config/initializers/bp3-paper_trail` initializer, specify the name of the class
that stores version records:
```ruby
Bp3::PaperTrail.version_class_name = 'Version'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `rake install`. To release a new
version, update the version number in `version.rb`, and then run `rake release`,
which will create a git tag for the version, push git commits and the created tag,
and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing
Run `rake` to run rspec tests and rubocop linting.

## Documentation
A `.yardopts` file is provided to support yard documentation.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
