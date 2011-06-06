Factory.define :user do |user|
  user.first_name "John"
  user.last_name "Doe"
  user.email "johndoe@mailinator.com"
  user.username "johndoe"
  user.gender "M"
  user.password "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

