glass1 = Glass.create(name: 'Martini', img_url: 'http://upload.wikimedia.org/wikipedia/commons/1/19/Coctail_glass.svg')
glass2 = Glass.create(name: 'Collins', img_url: 'http://upload.wikimedia.org/wikipedia/commons/e/e4/Collins_glass_silhouette.svg')

drink1 = Drink.create(name: 'The Nate Mistake', glass: glass1)
ingredient1 = Ingredient.create(name: 'Rum', hex_color: 'e67e22')
ingredient2 = Ingredient.create(name: 'Cherry Tomatoes', hex_color: 'e74c3c')
Component.create(drink: drink1, ingredient: ingredient1, quantity: 250)
Component.create(drink: drink1, ingredient: ingredient2, quantity: 75)

drink2 = Drink.create(name: 'Mojito', glass: glass2)
ingredient3 = Ingredient.create(name: 'Mint', hex_color: '2ecc71')
Component.create(drink: drink2, ingredient: ingredient1, quantity: 150)
Component.create(drink: drink2, ingredient: ingredient3, quantity: 25)

drink3 = Drink.create(name: 'Rum and Coke', glass: glass2)
ingredient4 = Ingredient.create(name: 'Coke', hex_color: '2c3e50')
Component.create(drink: drink3, ingredient: ingredient1, quantity: 50)
Component.create(drink: drink3, ingredient: ingredient4, quantity: 200)


