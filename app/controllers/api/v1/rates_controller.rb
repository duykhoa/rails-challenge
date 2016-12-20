class Api::V1::RatesController < ApiController
  def create
    rating = Rating.new(rating_model_klass: Rate)

    begin
      rating.rate(rate_params)
      msg = "Create rating successfully"
      status = 200
    rescue Rating::ParamerterException
      msg = "Can't create rating"
      status = 403
    end

    respond_to do |format|
      format.json {
        render json: { status: status, message: msg }, status: status
      }
    end
  end

  def rate_params
    {
      user_id: params["user_id"],
      ratable_id: params["ratable_id"],
      ratable_type: params["ratable_type"],
      point: params["point"]
    }
  end
end
