FactoryGirl.define do
  factory :audit_log do
    backtrace "MyString"
    data "MyString"
    user nil
  end
end
