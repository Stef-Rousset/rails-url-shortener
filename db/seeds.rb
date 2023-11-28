# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
p 'Deleting all sources'
Source.destroy_all
p 'Creating sources'
source_one = Source.create!(name: 'liberation', url: 'https://www.liberation.fr/arc/outboundfeeds/rss-all/collection/accueil-une/?outputType=xml')
source_two = Source.create!(name: "lemonde", url: 'https://www.lemonde.fr/rss/une.xml')
source_three =  Source.create!(name: 'lequipe', url: 'https://dwh.lequipe.fr/api/edito/rss?path=/')

p 'Sources created'

p 'Deleting Categories'
Category.destroy_all
p 'Creating categories'
cate_one = Category.create!(name: 'Salaire')
cate_two = Category.create!(name: 'Alimentation')
cate_three = Category.create!(name: 'Impots')
cate_four = Category.create!(name: 'Santé')
cate_five = Category.create!(name: 'Loisirs')
cate_six = Category.create!(name: 'Transports')
cate_seven = Category.create!(name: 'Habillement')
cate_eight = Category.create!(name: 'Loyer')
cate_nine = Category.create!(name: 'Charges')
p 'Categories created'
