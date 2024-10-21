require 'rails_helper'

RSpec.describe "product_histories/index", type: :view do
  before(:each) do
    assign(:product_histories, [
      ProductHistory.create!(
        price: 2.5,
        product: nil
      ),
      ProductHistory.create!(
        price: 2.5,
        product: nil
      )
    ])
  end

  it "renders a list of product_histories" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(2.5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
