require 'minitest/autorun'
require_relative '../main'

class BasketTest < Minitest::Test
  def setup
    @products = [
      Product.new(code: "R01", name: "Red Widget", price_cents: 3295),
      Product.new(code: "G01", name: "Green Widget", price_cents: 2495),
      Product.new(code: "B01", name: "Blue Widget", price_cents: 795)
    ]

    @catalogue = Catalogue.new(@products)
    @delivery_rules = DeliveryRuleSet.new([
      DeliveryRule.new(threshold_cents: 9000, fee_cents: 0),    # $90+
      DeliveryRule.new(threshold_cents: 5000, fee_cents: 295),  # $50–$89.99
      DeliveryRule.new(threshold_cents: 0,    fee_cents: 495)   # under $50
    ])

    @offers = [RedWidgetHalfPrice.new]
  end


  def test_example_basket_1
    basket = Basket.new(catalogue: @catalogue, delivery_rules: @delivery_rules, offers: @offers)
    %w[B01 G01].each { |code| basket.add(code) }

    assert_equal "$37.85", basket.total
  end

  def test_example_basket_2
    basket = Basket.new(catalogue: @catalogue, delivery_rules: @delivery_rules, offers: @offers)
    %w[R01 R01].each { |code| basket.add(code) }
    
    assert_equal "$54.37", basket.total
  end

  def test_example_basket_3
    basket = Basket.new(catalogue: @catalogue, delivery_rules: @delivery_rules, offers: @offers)
    %w[R01 G01].each { |code| basket.add(code) }

    assert_equal "$60.85", basket.total
  end

  def test_example_basket_4
    basket = Basket.new(catalogue: @catalogue, delivery_rules: @delivery_rules, offers: @offers)
    %w[B01 B01 R01 R01 R01].each { |code| basket.add(code) }

    assert_equal "$98.27", basket.total
  end
end
