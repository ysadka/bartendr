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
