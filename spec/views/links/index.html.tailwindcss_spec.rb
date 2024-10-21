require 'rails_helper'

RSpec.describe "links/index", type: :view do
  before(:each) do
    assign(:links, [
      Link.create!(
        url: "Url",
        category: nil
      ),
      Link.create!(
        url: "Url",
        category: nil
      )
    ])
  end

  it "renders a list of links" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Url".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
