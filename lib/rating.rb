class Rating
  def initialize(options = {})
    @rating_model_klass = options[:rating_model_klass] || Object
  end

  def rate(args = {})
    point = args[:point] || 1
    ratable_type = args[:ratable_type]
    ratable_id = args[:ratable_id]

    raise StandardError, "#ratable_id or #ratable_type is missing" unless ratable_id && ratable_type

    @rating_model_klass.create(
      ratable_id: ratable_id, point: point
    )
  end
end
