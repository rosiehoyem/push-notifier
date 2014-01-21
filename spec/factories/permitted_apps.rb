# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :permitted_app do
    authentication_token "MyString"
  end
end
