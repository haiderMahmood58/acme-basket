class Catalogue
  def initialize(products = [])
    @products = products.to_h { |product| [product.code, product] }
  end

  def find(code)
    @products[code]
  end
end
