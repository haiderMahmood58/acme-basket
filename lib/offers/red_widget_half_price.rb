class RedWidgetHalfPrice < Offer
  def apply(products)
    reds = products.select { |p| p.code == "R01" }
    return 0 if reds.size < 2

    discounted = reds.size / 2
    discount_cents = (reds.first.price_cents / 2.0 * discounted).round
    -discount_cents
  end
end
