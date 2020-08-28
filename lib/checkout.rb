class Checkout

  def initialize(promotional_rules = [])
    @available_promotions = promotional_rules
    @total = 0.0
    @basket = []
  end

  def scan(product)
    @basket << product

    # Because there might be an impact on previsouly added products' prices
    @total = 0.0

    # TODO: Determine simplest approach, iterate products and apply active promotions on spot or the other way
    # Could go through promotions first and check which ones are active then apply at the bottom
    # Could update price for each product on basket based on that instead of iterating and adding, but that would make it hard to rollback
    @basket.each do |product|

      product_promotion = @available_promotions
        .find do |promotion| 
          promotion.promotion_type == PromotionRuleType::PRODUCT_AMMOUNT and 
          promotion.product_code == product.code 
        end

      if product_promotion and 
        @basket.count { |product| product.code == product_promotion.product_code } >= product_promotion.activation_ammount
        price = case product_promotion.discount_type
        when PromotionDiscountType::ABSOLUTE
          product.price - product_promotion.discount_ammount
        when PromotionDiscountType::PERCENTUAL
          product.price * (1 - product_promotion.discount_ammount).to_f
        end
        @total += price
      else
        @total += product.price
      end
    end

    @available_promotions
      .select{ |promotion| promotion.promotion_type == PromotionRuleType::TOTAL_SPEND }
      .each do |promotion|
        # Asked for over ammount in spec
        if @total > promotion.activation_ammount
          @total = case promotion.discount_type
          when PromotionDiscountType::ABSOLUTE
            @total -= promotion.discount_ammount
          when PromotionDiscountType::PERCENTUAL
            @total * (1 - promotion.discount_ammount).to_f
          end
        end
      end

    # TODO: Determine if communication at this point is valuable
    @total.round(2)
  end

  def total
    @total.round(2)
  end

  def clear_basket
    @basket = []
    @total = 0.0
  end
end
