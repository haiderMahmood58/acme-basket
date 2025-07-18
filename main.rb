require_relative 'lib/models/product'
require_relative 'lib/catalogue'
require_relative 'lib/pricing/delivery_rule'
require_relative 'lib/pricing/delivery_rule_set'
require_relative 'lib/offers/offer'
require_relative 'lib/offers/red_widget_half_price'
require_relative 'lib/models/basket'

# Define products
products = [
  Product.new(code: "R01", name: "Red Widget", price_cents: 3295),
  Product.new(code: "G01", name: "Green Widget", price_cents: 2495),
  Product.new(code: "B01", name: "Blue Widget", price_cents: 795)
]

catalogue = Catalogue.new(products)

# Delivery pricing rules
delivery_rules = DeliveryRuleSet.new([
  DeliveryRule.new(threshold_cents: 9000, fee_cents: 0),   # $90+
  DeliveryRule.new(threshold_cents: 5000, fee_cents: 295), # $50–$89.99
  DeliveryRule.new(threshold_cents: 0,    fee_cents: 495)  # under $50
])

# Offers
offers = [RedWidgetHalfPrice.new]

# The combinations to print
test_combinations = [
  %w[B01 G01],
  %w[R01 R01],
  %w[R01 G01],
  %w[B01 B01 R01 R01 R01]
]

test_combinations.each do |codes|
  basket = Basket.new(catalogue: catalogue, delivery_rules: delivery_rules, offers: offers)
  codes.each { |code| basket.add(code) }
  puts "#{codes.join(', ')} \n#{basket.total}"
end
