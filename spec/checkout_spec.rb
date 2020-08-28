require "checkout"
require "product"
require "promotion_rule"
require "promotion_rule_type"
require "promotion_discount_type"

RSpec.describe Checkout do
  let(:chair) { Product.new("001", "Very Cheap Chair", 9.25) }
  let(:table) { Product.new("002", "Little Table", 45) }
  let(:light) { Product.new("003", "Funky Light", 19.95) }

  describe "calculate total for basket" do
    let(:total_spending_promotion) do
      PromotionRule.new(
        promotion_type: PromotionRuleType::TOTAL_SPENT,
        discount_type: PromotionDiscountType::PERCENTAGE,
        activation_ammount: 60, discount_ammount: 0.10
      )
    end
    let(:product_ammount_promotion) do
      PromotionRule.new(
        promotion_type: PromotionRuleType::PRODUCT_AMMOUNT,
        discount_type: PromotionDiscountType::ABSOLUTE,
        product_code: "001", activation_ammount: 2, discount_ammount: 0.75
      )
    end

    subject { Checkout.new([total_spending_promotion, product_ammount_promotion]) }
    after(:each) { subject.clear_basket }

    context "with no promotion" do
      before do
        subject.scan(chair)
        subject.scan(table)
      end
      it "should return regular price" do
        expect(subject.total).to eql(54.25)
      end
    end

    context "with a total spending based promotion" do
      before do
        subject.scan(chair)
        subject.scan(table)
        subject.scan(light)
      end
      it "should apply a total percentage discount" do
        expect(subject.total).to eql(66.78)
      end
    end

    context "with a product ammount based promotion" do
      before do
        subject.scan(chair)
        subject.scan(light)
        subject.scan(chair)
      end
      it "should apply a product pricing absolute discount" do
        expect(subject.total).to eql(36.95)
      end
    end

    context "with a product ammount based promotion making total go just under total spent based promotion" do
      before do
        7.times{ subject.scan(chair) }
      end
      it "should calculate promotions in the correct order" do
        expect(subject.total).to eql(59.5)
      end
    end

    context "with both product ammount and total spending based promotions" do
      before do
        subject.scan(chair)
        subject.scan(table)
        subject.scan(chair)
        subject.scan(light)
      end
      it "should apply both both types of discounts correctly" do
        expect(subject.total).to eql(73.76)
      end
    end

  end
end
