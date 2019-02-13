require "watir"
require "page-object"
require "feature-flags"

# Allow these methods to be available.
extend PageObject::PageFactory

# Load a yaml/json file or just add it ad-hoc.
FeatureFlags.load_file("spec/fixtures/flags.json")
# FeatureFlags.load_file("spec/fixtures/flags.yml")
FeatureFlags.add(:example_1, true)

class Home
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

    FeatureFlags.while_enabled(:example_1) do
      puts "Enabled"
    end

    FeatureFlags.while_disabled(:example_2) do
      puts "Disabled"
    end

    # Click on the modal here
    search_element.send_keys(value)

    # Printout the object to see what locator was used.
    puts search_element.inspect
  end

end # => end Home

#
# Example Runner
#
@browser = Watir::Browser.new(:chrome)
visit(Home).search_for("Ruby")