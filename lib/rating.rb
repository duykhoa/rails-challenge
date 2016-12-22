class Rating
  class ParamerterException < StandardError;end

  def initialize(options = {})
    @rating_model_klass = options[:rating_model_klass] || Object
  end

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
