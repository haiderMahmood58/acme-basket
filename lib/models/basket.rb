class Basket
  def initialize(catalogue:, delivery_rules:, offers: [])
    @catalogue = catalogue
    @delivery_rules = delivery_rules
    @offers = offers
    @items = []
  end

  def add(code)
    product = @catalogue.find(code)
    raise "Product not found: #{code}" unless product

    @items << product
  end

  def total
    subtotal = @items.sum(&:price_cents)
    offer_total = @offers.sum { |offer| offer.apply(@items) || 0 }
    delivery_fee = @delivery_rules.fee_for(subtotal + offer_total)

    total_cents = subtotal + offer_total + delivery_fee
    format("$%.2f", total_cents / 100.0)
  end

end
