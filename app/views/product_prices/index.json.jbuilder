json.array!(@product_prices) do |product_price|
  json.extract! product_price, :id, :price, :active, :user_id, :product_id
  json.url product_price_url(product_price, format: :json)
end
