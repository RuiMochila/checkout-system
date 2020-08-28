class PromotionRule
  # TODO: Model promotion rules

  # Promotion activation criteria
  #   - total spending type : spending_ammount
  #   - product count type : product_code, product_ammount
  # 

  # Discount type and data
  #  - price impact percentual : value
  #  - price impact absolute : value
  #  PromotionRule::Absolute / PromotionRule::Percentual
  #
  #  - target: product_level : which product_code
  #            basket level / inferred from missing target?

  attr_reader :promotion_type, :discount_type, :activation_ammount, :product_code, :discount_ammount

  def initialize(promotion_type:, discount_type:, activation_ammount:, product_code: nil, discount_ammount:)
    # TODO: Guard, product ammount promotion requires product_code
    @promotion_type = promotion_type
    @discount_type = discount_type
    @activation_ammount = activation_ammount
    @product_code = product_code
    @discount_ammount = discount_ammount
  end
end
