def hl_red(msg)
  "\e[31m#{msg}\e[0m"
end

def log(msg)
  decorate_msg = "--\s%s\n" % [hl_red(msg)]
  STDOUT << decorate_msg
end

log("Clear old data")

Order.delete_all
Meal.delete_all
Delivery.delete_all
OrderItem.delete_all
Rate.delete_all
User.delete_all

log("Create users")

[
  "kevin@gmail.com",
  "ernest@grain.sg",
  "admin@grain.sg",
].each { |email| User.create(email: email, password: 'grain_sg1234') }

order = Order.create(user: User.first)

log("Create Order, id #{order.id}")

m1 =  Meal.create(meal_name: "Chicken rice")
m2 =  Meal.create(meal_name: "Yong tau foo")

oi1 = OrderItem.create(qty: 1, meal: m1, order: order)
oi2 = OrderItem.create(qty: 2, meal: m2, order: order)

delivery = Delivery.create(order_id: order.id)
