require "watir"
require "page-object"
require "feature-flags"

# Make the page navigation methods available.
extend PageObject::PageFactory

# Load up your feature files anyway you want.
FeatureFlags.load_file("flags.json")
FeatureFlags.load_file("flags.yml")
FeatureFlags.add(:example_3, true)

class Home
  include PageObject
  include FeatureFlags

  page_url "https://www.google.com"

  text_field :search, name: "q"
  # text_field :search_2, aria_label: "Search"
  feature_flag :list_tag_modal_whoops, :search, :text_field, aria_label: "Search"


  def search_for
    # if FeatureFlags.enabled?(:list_tag_modal)
    # Click on the modal here
    search_element.send_keys "Hello world"
    puts search_element.inspect
    # end

  end
end

@browser = Watir::Browser.new(:chrome)
# on(Home)
@browser.goto("https://www.google.com")
on(Home).search_for
# sleep 10
# on(Home).search_element.send_keys "cucumber"
sleep 5