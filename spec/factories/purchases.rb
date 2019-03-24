require 'faker'

FactoryGirl.define do
  factory :purchase do
    user_id nil
    content_id nil
    variant_id nil
  end
end