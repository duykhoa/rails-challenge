class Delivery < ActiveRecord::Base
  has_many :rates, as: :ratable
  has_one :comment, as: :commentable

  # Public: Update Delivery rate point base on rate
  # It is used in the RateUpdateJob
  #
  # Example
  #
  #   Delivery.update_rate_point
  #
  # TODO:
  #
  # -  There is a problem with #find_by_sql, the result can't be saved.
  #   May check on Rails community for the issue.
  #
  #   E.g.
  #
  #     result = self.find_by_sql sql
  #     result.each do |dlv|
  #       dlv.save!
  #     end
  # - This code is duplicated on Meal model.
  def self.update_rate_point
    sql = <<-SQL
      select d.id, avg(r.point) as rate_point
      from rates r
      inner join deliveries d on d.id = r.ratable_id
      where ratable_type = 'Delivery'
      group by d.id
    SQL

    result = self.find_by_sql sql

    result.each do |delivery|
      self.update(delivery.id, rate_point: delivery.rate_point)
    end
  end
end
