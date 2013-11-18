require 'csv'
require './lib/assets/glass_mapping'

desc "Pass a CSV of drinks to create respective entries in the database"
task :parse_drinks, [:filename] => :environment do |t, args|
  CSV.foreach(args.filename, headers: true, header_converters: :symbol) do |row|
    glass_number = row[:glass].match(/glasses\/(.*)\//).captures.first.to_i
    glass = Glass.find_by(name: GLASS_MAPPING.fetch(glass_number, 'Pint'))

    Drink.create(
      name:        row[:name].downcase,
      preparation: row[:preparation],
      url:         row[:url],
      glass:       glass
    )
  end
end

desc "Pass a CSV of ingredients to create respective entries in the database"
task :parse_ingredients, [:filename] => :environment do |t, args|
  CSV.foreach(args.filename, headers: true, header_converters: :symbol) do |row|
    drink = Drink.find_by(url: row[:url])
    next unless drink # skip to the next row if it can't find a matching drink
    name = row[:name]

    ingredient = case name
      # order by most common ingredients
      when /light rum/ then Ingredient.find_by(name: 'Light Rum')
      when /dark rum/, /rum/ then Ingredient.find_by(name: 'Dark Rum')
      when /tomatoes/ then Ingredient.find_by(name: 'Cherry Tomatoes')
      when /mint leaves/ then Ingredient.find_by(name: 'Mint Leaves')
      when /cola/, /coke/ then Ingredient.find_by(name: 'Coke')
      when /vodka/ then Ingredient.find_by(name: 'Vodka')
      when /sec/ then Ingredient.find_by(name: 'Triple Sec')
      when /cranberry/ then Ingredient.find_by(name: 'Cranberry Juice')
      when /lime/ then Ingredient.find_by(name: 'Lime Juice')
      when /soda/ then Ingredient.find_by(name: 'Soda Water')
      when /coffee liqueur/ then Ingredient.find_by(name: 'Coffee Liqueur')
      when /coffee cream/ then Ingredient.find_by(name: 'Coffee Cream')
      when /gin/ then Ingredient.find_by(name: 'Gin')
      when /tonic/ then Ingredient.find_by(name: 'Tonic Water')
      when /whisky/, /whiskey/ then Ingredient.find_by(name: 'Whiskey')
      when /vermouth/ then Ingredient.find_by(name: 'Sweet Vermouth')
      when /lemon/ then Ingredient.find_by(name: 'Lemon Juice')
      when /sugar/ then Ingredient.find_by(name: 'Sugar')
      when /cherry/ then Ingredient.find_by(name: 'Cherry')
      when /tequila/ then Ingredient.find_by(name: 'Tequila')
      when /sour/ then Ingredient.find_by(name: 'Sweet and Sour Mix')
      when /cognac/ then Ingredient.find_by(name: 'Cognac')
      when /orange liqueur/ then Ingredient.find_by(name: 'Orange Liqueur')
      when /bull/ then Ingredient.find_by(name: 'Red Bull')
      when /jager/ then Ingredient.find_by(name: 'Jagermeister')
      when /grenadine/ then Ingredient.find_by(name: 'Grenadine')
      when /151/ then Ingredient.find_by(name: '151')
      when /amaretto/ then Ingredient.find_by(name: 'Amaretto')
      when /grapefruit/ then Ingredient.find_by(name: 'Grapefruit Juice')
      when /pineapple/ then Ingredient.find_by(name: 'Pineapple Juice')
      when /orange juice/, /oj/ then Ingredient.find_by(name: 'Orange Juice')
      when /orange/ then Ingredient.find_by(name: 'Orange')
      when /mango/ then Ingredient.find_by(name: 'Mango Juice')
      when /apple juice/ then Ingredient.find_by(name: 'Apple Juice')
      when /passionfruit/, /passion-fruit/ then Ingredient.find_by(name: 'Passionfruit Juice')
      when /tomato juice/ then Ingredient.find_by(name: 'Tomato Juice')
      when /pomegranate/ then Ingredient.find_by(name: 'Pomegranate Juice')
      when /pickle/ then Ingredient.find_by(name: 'Pickle Juice')
      when /olive juice/ then Ingredient.find_by(name: 'Olive Juice')
      when /grape juice/ then Ingredient.find_by(name: 'Grape Juice')
      when /vegetable/ then Ingredient.find_by(name: 'Vegetable Juice')
      when /clamto/ then Ingredient.find_by(name: 'Clamto Juice')
      when /fruit juice/ then Ingredient.find_by(name: 'Fruit Juice')
      when /peach schnapps/ then Ingredient.find_by(name: 'Peach Schnapps')
      when /raspberry/ then Ingredient.find_by(name: 'Raspberry Schnapps')
      when /butterscotch/ then Ingredient.find_by(name: 'Butterscotch Schnapps')
      when /mint schnapps/ then Ingredient.find_by(name: 'Mint Schnapps')
      when /wildberry/ then Ingredient.find_by(name: 'Wildberry Schnapps')
      when /cinnamon/ then Ingredient.find_by(name: 'Cinammon Schnapps')
      when /apple schnapps/ then Ingredient.find_by(name: 'Apple Schnapps')
      when /watermelon/ then Ingredient.find_by(name: 'Watermelon Schnapps')
      when /bourbon/ then Ingredient.find_by(name: 'Bourbon')
      when /scotch/ then Ingredient.find_by(name: 'Scotch')
      when /irish cream/ then Ingredient.find_by(name: 'Irish Cream')
      when /white wine/ then Ingredient.find_by(name: 'White Wine')
      when /red wine/ then Ingredient.find_by(name: 'Red Wine')
      when /champagne/ then Ingredient.find_by(name: 'Champagne')
      when /curacao/ then Ingredient.find_by(name: 'Blue Curacao Liqueur')
      when /coconut cream/ then Ingredient.find_by(name: 'Coconut Cream')
      when /coconut rum/ then Ingredient.find_by(name: 'Coconut Rum')
      when /chocolate liqueur/ then Ingredient.find_by(name: 'Chocolate Liqueur')
      when /melon/ then Ingredient.find_by(name: 'Melon Liqueur')
      when /peach liqueur/ then Ingredient.find_by(name: 'Peach Liqueur')
      when /bitters/ then Ingredient.find_by(name: 'Bitters')
      when /brandy/ then Ingredient.find_by(name: 'Brandy')
      else Ingredient.find_by(name: name.titleize)
    end

    unless ingredient
      color = Color.all.sample # random seeded color (before we decide a better way)
      ingredient = Ingredient.create(name: name.titleize, color: color)
    end

    next unless row[:quantity] # the scraper data is sorta error prone

    quantity_match = row[:quantity].match(/\d\S?\d?|fill/)

    next unless quantity_match # disregard quantites without a number

    quantity = quantity_match[0].to_i

    # filter for different measurements and convert to ounces
    quantity = case row[:quantity]
      when /cup/ then quantity * 800
      when /shot/ then quantity * 150
      when /tbsp/ then quantity * 50
      when /cl/ then quantity * 33.34
      when /tsp/ then quantity * 16.67
      when /dash/ then quantity * 10
      when /splash/ then quantity * 10
      when /ml/ then quantity * 3.38
      else quantity * 100
    end

    begin
      Component.create(drink: drink, ingredient: ingredient, quantity: quantity)
    rescue ActiveRecord::RecordNotUnique
      puts "Uniqueness constraint has trigged an error. No action needed."
    end
  end
end
