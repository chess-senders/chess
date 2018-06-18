FactoryBot.define do
  factory :player do
    sequence :email do |n|
      "dummyemail#{n}@gmail.com"
    end
    password 'password'
    playername ''
  end
end
