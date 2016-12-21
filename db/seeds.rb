Order.delete_all
Meal.delete_all
Delivery.delete_all
OrderItem.delete_all
Rate.delete_all

order = Order.create
puts order.id

m1 =  Meal.create(meal_name: "Chicken rice")
m2 =  Meal.create(meal_name: "Yong tau foo")

oi1 = OrderItem.create(qty: 1, meal: m1, order: order)
oi2 = OrderItem.create(qty: 2, meal: m2, order: order)

delivery = Delivery.create(order_id: order.id)
