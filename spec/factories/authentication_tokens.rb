FactoryGirl.define do
  factory :authentication_token do
    token "MyString"
    user nil
    expires_at 1.day.from_now
  end
end
