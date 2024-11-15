class SubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :url, :request_body

  def url
    "ws://localhost:3000/cable?category_id=#{object.id}"
  end

  def request_body
    {
      command: "subscribe",
      identifier: {
        channel: "SubscriptionsChannel"
      }.to_json
    }
  end
end