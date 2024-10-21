json.extract! product_history, :id, :price, :product_id, :created_at, :updated_at
json.url product_history_url(product_history, format: :json)
