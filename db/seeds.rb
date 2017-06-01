# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

uids = []
User.all.each { |u| uids << u.id }

listing = {}
ActiveRecord::Base.transaction do
	8.times do
	    listing['name'] = Faker::Commerce.product_name
        listing['price'] = Faker::Commerce.price
	    listing['description'] = Faker::Hipster.sentence
	    listing['condition'] = ["Used", "New"].sample
	    listing['category'] = [0, 1, 2, 3, 4].sample
	    listing['user_id'] = uids.sample
	    # uploader = PhotoUploader.new
	    # listing['photos'] = (File.open("app/assets/images/default-thumb.jpg")) 
        # listing['photos'] = remote_photos_url("public/fallback/default-thumbnail.jpg")
        # listing['photos'] = File.open(File.join(Rails.root, '/public/fallback/default-thumbnail.jpg')) 
        #ArgumentError: invalid byte sequence in UTF-8
	    list = Listing.create(listing)
	    list.photos = [Rails.root.join("public/fallback/default-thumbnail.jpg").open]
	    list.save!
	end
end
