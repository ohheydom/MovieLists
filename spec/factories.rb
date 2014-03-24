FactoryGirl.define do
  factory :user do
    username 'blinky1'
    email 'blink1@blink.com'
    password 'tester12'
    password_confirmation 'tester12'
  end

  factory :connector do
    user
    movie_id 12
  end
end
