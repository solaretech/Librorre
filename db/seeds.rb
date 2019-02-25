# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do |n|
  User.create(
    name: "神南#{n}",
    email: "jinnan-#{n}@librorre.com",
    password: 'test123',
    password_confirmation: 'test123'
  )
end

50.times do |n|
  Article.create(
    title: "エラー#{n}",
    user_id: rand(50),
    mean: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
    cause: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  )
end

50.times do |n|
  ArticleCategory.create(
    article_id: n,
    category_id: 1
  )
end

50.times do |n|
  story = Story.create(
    title: "ストーリー#{n}",
    article_id: rand(50),
    user_id: rand(50),
    story_topics_attributes: [
      {
        title: "Topic 1",
        story_bodies_attributes:[
          {
            text_type: 0,
            content: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
          },
          {
            text_type: 1,
            content: "</div> Code Test 1 </div>"
          }
        ]
      },
      {
        title: "Topic 2",
        story_bodies_attributes:[
          {
            text_type: 0,
            content: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
          },
          {
            text_type: 1,
            content: "</div> Code Test 2 </div>"
          }
        ]
      },
      {
        title: "Topic 3",
        story_bodies_attributes:[
          {
            text_type: 0,
            content: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
          },
          {
            text_type: 1,
            content: "</div> Code Test 3 </div>"
          }
        ]
      }
    ]
  )
end


50.times do |n|
  StoryCategory.create(
    story_id: n,
    category_id: 1
  )
end