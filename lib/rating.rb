class Rating
  def initialize(options = {})
    @rating_model_klass = options[:rating_model_klass] || Object
  end

  # Public: Update rate_point for +Delivery+ and +Meal+
  #
  # args - Hash options (default: {})
  #       :delivery   - Hash of delivery rate, followed format ({id: value})
  #       :order_item - Hash of order item rate, followed format ({id1: value})
  #
  # Examples
  #
  #   args = { delivery: {1: 2}, order_item: {5: 1, 99: 2}}
  #   rating = Rating.new(rating_model_klass: Rate)
  #   rating.rate(args)
  def rate(args = {})
    delivery = args[:delivery]
    order_item = args[:order_item]

    delivery.each do |k,v|
      @rating_model_klass.create(ratable_id: k, ratable_type: "Delivery", point: v)
    end

    order_item.each do |k,v|
      @rating_model_klass.create(ratable_id: k, ratable_type: "OrderItem", point: v)
    end
  end
end
