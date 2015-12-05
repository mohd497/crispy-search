# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


sample_data = [
    'ที่พักกระบี่', 'adwords', 'Nikon', 'Canon', 'Le Cordon Bleu',
    'ราคาทอง', 'ตอนโด', 'pebble', 'La Roche-Posay', 'Chloé',
    'hotel booking', 'trip advisor', 'car rent', 'ensogo', 'casino apps'
]

# Create sample data
sample_data.each { |key| Keyword.find_or_create_by(text: key) }


user = User.first_or_create(name: 'John Doe', avatar: Faker::Avatar.image,
    email: 'demo@example.com', password: '123456')

app = Doorkeeper::Application.first_or_create(name: 'Crispy Search', redirect_uri: Faker::Internet.url)
access_token = Doorkeeper::AccessToken.create(application: app, resource_owner_id: user)

puts <<-eos
===================================================================================
Welcome!! #{user.name}
EMAIL: demo@example.com
PASSWORD: 123456

API ACCESS CODE: #{access_token.token}

## IF TOKEN EXPIRED YOU CAN RUN SEED AGAIN
===================================================================================
eos

