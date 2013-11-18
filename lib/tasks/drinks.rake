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
  CSV.foreach(args.filename, headers: true) do |row|
    drink = Drink.find_by(url: row[:url])

    next unless drink # skip to the next row if it can't find a matching drink

    name = row[:name]

    ingredient = case name
      when /rum/ then Ingredient.find_by(name: 'Rum')
      when /vodka/ then Ingredient.find_by(name: 'Vodka')
      when /cola/ then Ingredient.find_by(name: 'Coke')
      when /whisky/, /whiskey/ then Ingredient.find_by(name: 'Whiskey')
      when /coffee liqueur/ then Ingredient.find_by(name: 'Coffee Liqueur')
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
