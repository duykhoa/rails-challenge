order = Order.create
puts order.id

m1 =  Meal.create(meal_name: "Chicken rice", order_id: order.id)
ma =  Meal.create(meal_name: "Yong tau foo", order_id: order.id)
