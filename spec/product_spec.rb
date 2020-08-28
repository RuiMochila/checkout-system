require "product"

RSpec.describe Product do
  it "has a code" do
    expect(described_class.new("001", nil, nil).code).to eq("001")
  end

  it "has a name" do
    expect(described_class.new(nil, "Name", nil).name).to eq("Name")
  end

  it "has a price" do
    expect(described_class.new(nil, nil, 9.25).price).to eq(9.25)
  end
end
