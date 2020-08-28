require "checkout"
require "product"

RSpec.describe Checkout do
  let(:chair) { Product.new("001", "Very Cheap Chair", 9.25) }
  let(:table) { Product.new("002", "Little Table", 45) }
  let(:light) { Product.new("003", "Funky Light", 19.95) }

  describe "#scan" do
    pending "Determine format of test"
  end

  describe "#total" do
    # TODO: Initialize subject with same promotion rules
    # TODO: Add promotional rules after determining required format
    subject { Checkout.new }
    after(:each) { subject.clear_basket }

    context "with a total spending based discount" do
      before do
        subject.scan(chair)
        subject.scan(table)
        subject.scan(light)
      end
      it "should apply a total percentual discount" do
        expect(subject.total).to eql(66.78)
      end
    end

    context "with a product ammount based discount" do
      before do
        subject.scan(chair)
        subject.scan(light)
        subject.scan(chair)
      end
      it "should apply a product pricing absolute discount" do
        expect(subject.total).to eql(36.95)
      end
    end

    context "with both product ammount and total spending based discounts" do
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
