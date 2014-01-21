# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "MyString"
    sex "MyString"
    device nil
  end
end
