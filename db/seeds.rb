User.find_or_create_by!(email: "example@railstutorial.org") do |user|
  user.name = "Example User"
  user.password = "foobar"
  user.password_confirmation = "foobar"
  user.admin = true
end

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.find_or_create_by!(email: email) do |user|
    user.name = name
    user.password = password
    user.password_confirmation = password
  end
end


# マイクロポスト
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

# ユーザーをランダムにフォローする（重複チェックを追加）
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]

following.each { |followed| user.follow(followed) unless user.following?(followed) }
followers.each { |follower| follower.follow(user) unless follower.following?(user) }