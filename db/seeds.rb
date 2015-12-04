# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


sample_data = ['ที่พักกระบี่', 'adwords', 'Nikon', 'Canon', 'Le Cordon Bleu', 'ราคาทอง', 'ตอนโด', 'pebble', 'La Roche-Posay', 'Chloé']

sample_data.each { |key| Keyword.find_or_create_by(text: key) }
