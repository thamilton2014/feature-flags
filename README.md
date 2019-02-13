# FeatureFlags

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/feature_flags`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'feature_flags'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install feature_flags

## Usage

Adding/Configuring feature flags.
```ruby
FeatureFlags.configure do |flag|
  flag[:example_1] = true
end
```

Adding feature flag
```ruby
FeatureFlags.add(:example_1, true)
```

Adding feature flags using YAML
```ruby
FeatureFlags.load_file("example.yml")
```

Adding feature flags using JSON
```ruby
FeatureFlags.load_file("example.json")
```

Adding feature flags using Hash
```ruby
flags = {
  flags: [
    name: "exmple_1",
    enabled: true
  ]
}
FeatureFlags.add_flags(flags)
```

# Check if the feature flag is enabled.
```ruby
FeatureFlags.enabled?(:example_1) # => true
```

# Check if the feature flag is disabled.
```ruby
FeatureFlags.disabled?(:example_1) # => false
```

# Enables the feature flag by setting it to true.
```ruby
FeatureFlags.enable(:example_1)
```

# Disables the feature flag by setting it to false
```ruby
FeatureFlags.disable(:example_1)
```

```ruby
FeatureFlags.while_enabled(:example_1) do
  # Do something if example_1 is enabled.
end
```

```ruby
FeatureFlags.while_disabled(:example_1) do
  # Do something if example_1 is disabled
end
```

Include the feature flags gem in the Page Object
```ruby
class GooglePage
  include PageObject
  include FeatureFlags
  
  page_url "https://www.google.com"
  
  # The initial element and it's locator.
  text_field :search, name: "q"  
  # The updated element and it's locator.
  feature_flag :example_1, :search, :text_field, aria_label: "Search"  

  # Description:
  #   If the list_tag_modal is enabled, the if logic is enabled and the element will be located via aria_label.
  #
  # @param [String] value - The input value to search for.
  def search_for(value)
    if FeatureFlags.enabled?(:example_1)
      # Do something here if :list_tag_modal is enabled.
    end
    # Click on the modal here
    search_element.send_keys(value)
    
    # Printout the object to see what locator was used.
    puts search_element.inspect
  end
end # => end HomePage
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/feature_flags. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FeatureFlags project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/feature_flags/blob/master/CODE_OF_CONDUCT.md).
