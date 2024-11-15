json.extract! notification, :id, :status, :product_id, :created_at, :updated_at
json.url notification_url(notification, format: :json)
