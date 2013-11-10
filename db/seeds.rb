drink1 = Drink.create(name: 'The Nate Mistake')
ingredient1 = Ingredient.create(name: 'Rum', hex_color: 'A16D0D')
ingredient2 = Ingredient.create(name: 'Cherry Tomatoes', hex_color: 'F51B26')
Component.create(drink: drink1, ingredient: ingredient1, quantity: 250)
Component.create(drink: drink1, ingredient: ingredient2, quantity: 75)

drink2 = Drink.create(name: 'Mojito')
ingredient3 = Ingredient.create(name: 'Mint', hex_color: '35B235')
Component.create(drink: drink2, ingredient: ingredient1, quantity: 150)
Component.create(drink: drink2, ingredient: ingredient3, quantity: 25)

drink3 = Drink.create(name: 'Rum and Coke')
ingredient4 = Ingredient.create(name: 'Coke', hex_color: '1A0806')
Component.create(drink: drink3, ingredient: ingredient1, quantity: 50)
Component.create(drink: drink3, ingredient: ingredient4, quantity: 200)

