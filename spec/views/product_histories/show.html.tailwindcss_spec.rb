require 'rails_helper'

RSpec.describe "product_histories/show", type: :view do
  before(:each) do
    assign(:product_history, ProductHistory.create!(
      price: 2.5,
      product: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(//)
  end
end
