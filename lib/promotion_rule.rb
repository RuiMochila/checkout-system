class PromotionRule
  attr_reader :promotion_type, :discount_type, :activation_ammount, :product_code, :discount_ammount

  def initialize(promotion_type:, discount_type:, activation_ammount:, product_code: nil, discount_ammount:)
    @promotion_type = promotion_type
    @discount_type = discount_type
    @activation_ammount = activation_ammount
    @product_code = product_code
    @discount_ammount = discount_ammount
  end
end
