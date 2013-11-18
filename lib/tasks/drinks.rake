require 'csv'
require './lib/assets/glass_mapping'
require './lib/assets/ingredients_filter'
require './lib/assets/quantities_filter'

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
    name = row[:ingredient].to_s
    ingredient = nil

    INGREDIENTS_FILTER.each do |k, v|
      ingredient = Ingredient.find_by(name: v) and break if name.match(k)
    end

    ingredient = Ingredient.find_by(name: name.titleize) unless ingredient

    unless ingredient
      color = Color.all.sample # random seeded color
      ingredient = Ingredient.create(name: name.titleize, color: color)
    end

    next unless row[:quantity] # the scraper data is sorta error prone

    quantity_match = row[:quantity].match(/\d\S?\d?|fill/)

    next unless quantity_match # disregard quantites without a number

    quantity = quantity_match[0].to_i

    # filter for different measurements and convert to ounces
    QUANTITIES_FILTER.each do |k, v|
      quantity *= v and break if row[:quantity].match(k)
    end

    begin
      Component.create(drink: drink, ingredient: ingredient, quantity: quantity)
    rescue ActiveRecord::RecordNotUnique
      puts "Uniqueness constraint has trigged an error. No action needed."
    end
  end
end
