require 'rails_helper'

RSpec.describe "notifications/show", type: :view do
  before(:each) do
    assign(:notification, Notification.create!(
      status: "Status",
      product: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Status/)
    expect(rendered).to match(//)
  end
end
