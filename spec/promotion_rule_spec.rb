require "promotion_rule"
require "promotion_rule_type"
require "promotion_discount_type"

RSpec.describe PromotionRule do
  subject do 
    PromotionRule.new(
      promotion_type: PromotionRuleType::PRODUCT_AMMOUNT,
      discount_type: PromotionDiscountType::ABSOLUTE,
      product_code: "001", activation_ammount: 2, discount_ammount: 0.75
    )
  end

  it "has a promotion type" do
    expect(subject.promotion_type).to eq(PromotionRuleType::PRODUCT_AMMOUNT)
  end

  it "has a discount_type" do
    expect(subject.discount_type).to eq(PromotionDiscountType::ABSOLUTE)
  end

  it "has a product_code" do
    expect(subject.product_code).to eq("001")
  end

  it "has an activation_ammount" do
    expect(subject.activation_ammount).to eq(2)
  end

  it "has a discount_ammount" do
    expect(subject.discount_ammount).to eq(0.75)
  end
end
