require 'rails_helper'

RSpec.describe "product_histories/edit", type: :view do
  let(:product_history) {
    ProductHistory.create!(
      price: 1.5,
      product: nil
    )
  }

  before(:each) do
    assign(:product_history, product_history)
  end

  it "renders the edit product_history form" do
    render

    assert_select "form[action=?][method=?]", product_history_path(product_history), "post" do

      assert_select "input[name=?]", "product_history[price]"

      assert_select "input[name=?]", "product_history[product_id]"
    end
  end
end
