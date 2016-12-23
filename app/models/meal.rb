class Meal < ActiveRecord::Base
  # Public: Update Meal rate point base on rate
  # It is used in the RateUpdateJob
  #
  # Example
  #
  #   Meal.update_rate_point
  #
  # TODO:
  #
  # - There is a problem with #find_by_sql, the result can't be saved.
  #   May check on Rails community for the issue.
  #
  #   E.g.
  #
  #     result = self.find_by_sql sql
  #     result.each do |dlv|
  #       dlv.save!
  #     end
  # - This code is duplicated on Delivery model.
  def self.update_rate_point
    sql = <<-SQL
      select m.id, avg(r.point) as rate_point
      from rates r
      inner join order_items oi on r.ratable_id = oi.id
      inner join meals m on m.id = oi.meal_id
      where ratable_type = 'OrderItem'
      group by m.id
    SQL

    result = self.find_by_sql sql

    result.each do |meal|
      self.update(meal.id, rate_point: meal.rate_point)
    end
  end
end
