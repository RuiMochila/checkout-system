class Checkout

  def initialize(promotional_rules = [])
    # TODO: Store promotional rules in state
    # - Init available promotions and active promotions array
    # TODO: Initialize basket
  end

  def scan(product)
    # TODO: Add product to the basket and check if any promotions are activated
    # TODO: If promotion meets trigger criteria, shift it to active promotions array
    # TODO: Go through product based promotions and apply them
    # TODO: Go through total spending promotions and apply them
    # TODO: Determine if communication at this point is valuable
  end

  def total
    # TODO: Return calculated total
  end

  def clear_basket
    # TODO: Reset basket and totals
  end
end
