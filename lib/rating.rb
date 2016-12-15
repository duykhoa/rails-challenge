class Rating
  def initialize(options = {})
    @rating_model_klass = options[:rating_model_klass] || Object
  end

  def rate(args = {})
    point = args[:point] || 1
    ratable_type = args[:ratable_type]
    ratable_id = args[:ratable_id]
    user_id = args[:user_id]

    raise StandardError, "#ratable_id or #ratable_type is missing" unless ratable_id && ratable_type && user_id

    @rating_model_klass.create(
      ratable_id: ratable_id,
      ratable_type: ratable_type,
      user_id: user_id,
      point: point
    )
  end
end
