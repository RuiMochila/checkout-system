class Checkout

  def initialize(promotional_rules = [])
    @available_promotions = promotional_rules
    @total = 0.0
    @basket = []
  end

  def scan(product)
    @basket << product
    @total = 0.0

    @basket.each do |product|

      product_promotion = available_promotion_for(product: product)

      if product_promotion and meets_promotion_ammount_criteria(promotion: product_promotion, product: product)
        price = case product_promotion.discount_type
        when PromotionDiscountType::ABSOLUTE
          product.price - product_promotion.discount_ammount
        when PromotionDiscountType::PERCENTAGE
          product.price * (1 - product_promotion.discount_ammount).to_f
        end
        @total += price
      else
        @total += product.price
      end
    end

    @available_promotions
      .select{ |promotion| promotion.promotion_type == PromotionRuleType::TOTAL_SPENT }
      .each do |promotion|
        if @total > promotion.activation_ammount
          @total = case promotion.discount_type
          when PromotionDiscountType::ABSOLUTE
            @total -= promotion.discount_ammount
          when PromotionDiscountType::PERCENTAGE
            @total * (1 - promotion.discount_ammount).to_f
          end
        end
      end

    total
  end

  def total
    @total.round(2)
  end

  def clear_basket
    @basket = []
    @total = 0.0
  end

  private
  def available_promotion_for(product:)
    @available_promotions
      .find do |promotion| 
        promotion.promotion_type == PromotionRuleType::PRODUCT_AMMOUNT and 
        promotion.product_code == product.code 
      end
  end

  def meets_promotion_ammount_criteria(promotion:, product:)
    @basket.count { |product| product.code == promotion.product_code } >= promotion.activation_ammount
  end

end
