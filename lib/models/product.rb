class Product
  attr_reader :code, :name, :price_cents

  def initialize(code:, name:, price_cents:)
    @code = code
    @name = name
    @price_cents = price_cents
  end
end
