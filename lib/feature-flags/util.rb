# lib/feature/util.rb
module FeatureFlags
  class Util
    attr_accessor :flags

    # Description:
    #   The main class in which we interact with our feature flags
    #
    def initialize
      @flags = {}

      yield(self) if block_given?
    end

    # Description:
    #   The main method that creates a default object if one doesn't already exist
    #
    # Example:
    #   Util.default
    #
    def self.default
      @@default ||= Util.new
    end

    # Description:
    #   Creates a new Util object using Ruby block
    #
    # Example:
    #   Util.configure do |config|
    #     config[:example] = true
    #   end
    #
    def configure
      yield(self) if block_given?
    end

    # Description:
    #   TODO: Add description
    #
    # Example:
    #   Util.default[:example] = true
    #
    # @param name
    # @param value
    def []=(name, value)
      @flags[name] = value
    end

  end # => end Util
end # => end FeatureFlags