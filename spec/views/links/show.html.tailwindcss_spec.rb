require 'rails_helper'

RSpec.describe "links/show", type: :view do
  before(:each) do
    assign(:link, Link.create!(
      url: "Url",
      category: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Url/)
    expect(rendered).to match(//)
  end
end
