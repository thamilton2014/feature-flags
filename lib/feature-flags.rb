# lib/feature-flag.rb
require "feature-flags/version"

module FeatureFlags
  require "feature-flags/flag"
  require "feature-flags/util"

  include Flag

  # Description:
  #   Main method in which we can include our `feature_flag` method inside a page object
  #
  # @param cls
  def self.included(cls)
    cls.extend FeatureFlags::Flag
  end

  class << self

    # Description:
    #   Configure the features that are within scope and whether or not they are enabled/disabled.
    #
    # Example:
    #
    # FeatureFlags.configure do |flag|
    #   flag[:example]    = true
    #   flag[:example_2]  = false
    # end
    #
    def configure
      if block_given?
        yield(Util.default)
      else
        Util.default
      end
    end

    # Description:
    #   This is to add one-off flags prior to page object initialization.
    #
    # Example:
    #   FeatureFlags.add(:example, true)
    #
    # @param flag_name
    # @param flag_value
    def add(flag_name, flag_value)
      Util.default.flags[flag_name.downcase.to_sym] = flag_value
    end

    # Description:
    #   This adds a helper method that allows for yml or json file extensions to be found and loaded.
    #   It then proceeds to add each key/value pair to our object.
    #
    # @param [String] file
    def load_file(file)
      ext  = File.extname(file)
      original_file = File.open(file)

      case ext
      when ".yml"
        file = YAML.load(original_file)
      when ".json"
        file = JSON.load(original_file)
      else
        raise Exception, "[] File type not found: #{file} - #{file.class}"
      end

      add_flags(file["flags"])
    end

    # Description:
    #   This is a collection method that adds the key/value pair of our feature flags into our page objects.
    #
    # Example:
    #   FeatureFlags.load_file("flags.json")
    #             or
    #   FeatureFlags.load_file("flags.yml")
    #
    # @param [Hash] flags
    def add_flags(flags)
      flags.each do |flag|
        add(flag["name"], flag["enabled"])
      end
    end

    # Description:
    #   This is an ad-hoc method to add a string of flags:
    #
    # Example:
    #   flags = "FLAG_1=hello,FLAG_2=world"
    #   FeatureFlags.add_string(flags)
    #
    # @param flags
    def add_string(flags)
      flags.split(",").each do |flag|
        key, value = flag.split("=")
        add(key, value)
      end
    end

    # Description:
    #   This is an ad-hoc method to add a list of flags:
    #
    # Example:
    #   flags = ["FLAG_1=hello", "FLAG_2=world"]
    #   FeatureFlags.add_array(flags)
    #
    def add_array(flags)
      flags.each do |flag|
        key, value = flag.split("=")
        FeatureFlags.add(key, value)
      end
    end

    def while_enabled(flag_name)
      if enabled?(flag_name.to_sym)
        yield if block_given?
      end
    end

    def while_disabled(flag_name)
      if disabled?(flag_name.to_sym)
        yield if block_given?
      end
    end

    # Description:
    #   Determines if the flag is enabled
    #
    # Example:
    #   FeatureFlags.enabled?(:example) # => true
    #
    # @param flag_name
    def enabled?(flag_name)
      if Util.default.flags.has_key?(flag_name)
        if Util.default.flags[flag_name]
          return true
        else
          return false
        end
      else
        puts "Flag not found: #{flag_name}"
      end
    end

    # Description:
    #   Determines if the flag is disabled
    #
    # Example:
    #   FeatureFlags.disabled?(:example) # => false
    #
    # @param flag_name
    def disabled?(flag_name)
      Util.default.flags.has_key?(flag_name)
    end

    # Description
    #   Enables a flag prior to page object initialization
    #
    # Example:
    #   FeatureFlags.enable(:example)
    #
    # @param flag_name
    def enable(flag_name)
      Util.default.flags[flag_name] = true
    end

    # Description
    #   Disables a flag prior to page object initialization
    #
    # Example:
    #   FeatureFlags.disable(:example)
    #
    # @param flag_name
    def disable(flag_name)
      Util.default.flags[flag_name] = false
    end

  end # => end self
end # => end FeatureFlags
