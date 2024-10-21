require 'rails_helper'

RSpec.describe "product_histories/new", type: :view do
  before(:each) do
    assign(:product_history, ProductHistory.new(
      price: 1.5,
      product: nil
    ))
  end

  it "renders new product_history form" do
    render

    assert_select "form[action=?][method=?]", product_histories_path, "post" do

      assert_select "input[name=?]", "product_history[price]"

      assert_select "input[name=?]", "product_history[product_id]"
    end
  end
end
