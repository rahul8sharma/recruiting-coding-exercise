class Product < ActiveRecord::Base
  # Stored all currencies in constant
  ALL_CORRENCIES = Currency::get_currencies

  def price
    price_in_cents / 100.0
  end
end
