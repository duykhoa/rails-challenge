class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :rememberable, :trackable, :validatable

  has_many :orders

  def ratable?(order_id)
    r = User.find_by_sql ratable_sql(order_id, self.id)
    r[0][:result] == "true"
  end

  private

  def ratable_sql(order_id, user_id)
    <<-SQL
      select
        case
          when count(1) = 0
          then 'true'
          else 'false'
        end as result
      from rates r
      inner join order_items oi on oi.id = r.ratable_id and r.ratable_type = "order_item"
      inner join orders ord on oi.order_id = ord.id
      inner join users u on u.id = ord.user_id
      where ord.id = #{order_id} and u.id = ord.user_id
    SQL
  end
end
