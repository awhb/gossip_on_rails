# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
2.times do |i|
  User.create(
    username: "adminbin#{i + 1}",
    password: "1234"
  )

  Post.create(
    title: "Thread #{i + 1}",
    content: "test test",
    user_id: 1,
    categories: ["test", "test2"]
  )

  Comment.create(
    content: "Comment #{i + 1}",
    user_id: 1,
    post_id: 1
  )
end

