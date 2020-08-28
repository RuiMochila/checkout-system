class Checkout

  def initialize(promotional_rules = [])
    @available_promotions = promotional_rules
    @active_promotions = []
    @total = 0.0
    @basket = []
  end

  def scan(product)
    @basket << product

    # TODO: Go through product based promotions and apply them if they meet criteria
    
    # TODO: Go through total spending promotions and apply them if they meet criteria

    @total = @total + product.price

    # TODO: Determine if communication at this point is valuable
  end

  def total
    @total
  end

  def clear_basket
    @basket = []
    @total = 0.0
    @available_promotions << @active_promotions
  end
end
