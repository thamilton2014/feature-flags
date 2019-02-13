# lib/feature/flag.rb
module FeatureFlags
  module Flag

    # Description:
    #   This enables us to create a method on an object at runtime to override any already
    #   existing elements if a feature flag is enabled.
    #
    # @param flag_name
    # @param element_name
    # @param tag
    # @param name
    def feature_flag(flag_name, element_name, tag, locator = {})
      if FeatureFlags.enabled?(flag_name.to_sym)
        self.send(tag, element_name, locator)
      end
    end

  end # => end Flag
end # => end FeatureFlags