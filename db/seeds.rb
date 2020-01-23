# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
i = 1

Post.destroy_all

30.times do
  Post.create!(
    title: "Stock post #{i}",
    body_one: "Lorem impsum dolar Lorem impsum dolar Lorem impsum dolar Lorem impsum dolar Lorem impsum dolar Lorem impsum dolar Lorem impsum dolar Lorem impsum dolar Lorem impsum dolar Lorem impsum dolar Lorem impsum dolar Lorem impsum dolar ",
    synopsis: "A short synopsis about the post",
    published: true
  )

  i += 1
end
