user_1 = User.create email: 'railssuperhero@email.com', password: 'password', password_confirmation: 'password'
user_2 = User.create email: 'railshero@email.com', password: 'password', password_confirmation: 'password'
user_3 = User.create email: 'railsrookie@email.com', password: 'password', password_confirmation: 'password'
ApiKey.create token: '12345654321'

item_1 = Item.create name: 'Pran Drinko Float Lichi Drinkt 250ml', description: 'It is a instant drink made with a lot of sugar. If you dribnk this, you will have diabetes for sure.', price: 30, available_quantity: 100
item_2 = Item.create name: 'Clemon 500ml', description: 'It is a good lemon flavoured drink', price: 35, available_quantity: 100
item_3 = Item.create name: 'Mojo 1L', description: 'lots of sugar and tastes bad', price: 45, available_quantity: 100


# order_1 = Order.create user: user_1, total_price: 80


# ordered_item_1 = OrderedItem.create order: order_1, item: item_2, quantity: 1
# ordered_item_2 = OrderedItem.create order: order_1, item: item_3, quantity: 1

