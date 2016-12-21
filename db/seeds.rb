Order.delete_all
Meal.delete_all
Delivery.delete_all

order = Order.create
puts order.id

m1 =  Meal.create(meal_name: "Chicken rice", order_id: order.id)
m2 =  Meal.create(meal_name: "Yong tau foo", order_id: order.id)

delivery = Delivery.create(order_id: order.id)
