require 'rails_helper'

describe Delivery, type: :model do
  it "has many rates" do
    delivery = Delivery.create
    rate = delivery.rates.build
    rate.save
    expect(delivery.rates.size).to eq 1
  end

  it "has one comment" do
    delivery = Delivery.create
    comment = delivery.build_comment
    comment.save
    expect(delivery.comment).to eq comment
  end

  describe "update_rate_point" do
    def assert_delivery_rate_point_with(rates, expected_rate_point)
      delivery = Delivery.create

      rates.each do |i|
        rate = delivery.rates.build
        rate.point = i
        rate.save
      end

      Delivery.update_rate_point
      delivery.reload

      expect(delivery.rate_point).to eq expected_rate_point
    end

    it "with 1 rate" do
      assert_delivery_rate_point_with([1], 1)
      assert_delivery_rate_point_with([5], 5)
      assert_delivery_rate_point_with([3], 3)
    end

    it "more rates" do
      assert_delivery_rate_point_with([1,3], 2)
      assert_delivery_rate_point_with([1,2,3,4,5], 3)
    end

    it "rate can be decimal" do
      assert_delivery_rate_point_with([1,2], 1.5)
      assert_delivery_rate_point_with([1,2,3,4,5,1,1,1], 2.25)
    end
  end
end
