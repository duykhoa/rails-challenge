class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :rememberable, :trackable, :validatable

  has_many :orders

  # Public: Check if user can give a feedback (rate and comment)
  # on an order
  #
  #   order_id - An Integer representation of Order id
  #
  # Example
  #
  #   user = User.first
  #   user.ratable?(1)
  #
  # Return true or false
  def ratable?(order_id)
    r = User.find_by_sql ratable_sql(order_id)
    r[0][:result] == "true"
  end

  # Public: Check if user own an order_id
  #
  #   order_id - An Integer representation of Order id
  #
  # Example
  #
  #   user = User.first
  #   user.own?(1)
  #
  # Returns true of false
  def own?(order_id)
    !!self.orders.find_by_id(order_id)
  end

  private

  # Internal: The sql is used to check in #ratable? method
  #
  #   order_id - an Integer representation of Order id
  #
  # Return a sql String
  def ratable_sql(order_id)
    <<-SQL
      select
        case
          when count(1) = 0
          then 'true'
          else 'false'
        end as result
      from rates r
      inner join order_items oi on oi.id = r.ratable_id and r.ratable_type = "OrderItem"
      inner join orders ord on oi.order_id = ord.id
      inner join users u on u.id = ord.user_id
      where ord.id = #{order_id} and ord.user_id = #{id}
    SQL
  end
end
