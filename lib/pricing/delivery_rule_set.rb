class DeliveryRuleSet
  def initialize(rules = [])
    @rules = rules.sort_by(&:threshold_cents).reverse.freeze
  end

  def fee_for(subtotal_cents)
    @rules.find { |rule| rule.applicable?(subtotal_cents) }&.fee || 0
  end
end
