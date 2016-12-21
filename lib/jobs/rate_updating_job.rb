class RateUpdatingJob
  PERRIOD = 1.minute.freeze

  def initialize(options = {})
    self.last_run_at = current_time - PERRIOD
    @meal_repository = options[:meal_repository]
    @delivery_repository = options[:delivery_repository]
  end

  def last_run_at
    @last_run_at
  end

  def last_run_at=(time)
    @last_run_at = time
  end

  def perform
    run if need_to_run
  end

  def need_to_run
    last_run_at + PERRIOD < current_time
  end

  alias_method :need_to_run?, :need_to_run

  def current_time
    Time.now
  end

  def run
    before_run_action
    update_meal_rate
    update_deliver_rate
  end

  def update_meal_rate
    @meal_repository.update_rate
  end

  def update_deliver_rate
    @delivery_repository.update_rate
  end

  def before_run_action
    self.last_run_at = Time.now
  end
end
