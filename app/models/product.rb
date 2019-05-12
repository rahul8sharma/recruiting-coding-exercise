class Product < ActiveRecord::Base
  # Stored all currencies in constant
  ALL_CORRENCIES = Currency::get_currencies
  # Set default Currency
  DEFAULT_CURRENCY = 'EUR'

  def price
    price_in_cents / 100.0
  end

  def get_price_by_currency(currency)
    if ALL_CORRENCIES[currency].present?
      ((price_in_cents / 100.0) * ALL_CORRENCIES[currency].to_f).round(2)
    else
      errors.add(:price_in_cents, :invalid, message: "Currency type is invalid")
    end
  end
end
