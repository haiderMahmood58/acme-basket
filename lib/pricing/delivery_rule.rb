class DeliveryRule
  attr_reader :threshold_cents, :fee

  def initialize(threshold_cents:, fee_cents:)
    @threshold_cents = threshold_cents
    @fee = fee_cents
  end

  def applicable?(subtotal_cents)
    subtotal_cents >= threshold_cents
  end
end
