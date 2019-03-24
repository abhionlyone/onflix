require 'faker'

FactoryGirl.define do
  factory :movie do
    title { Faker::Movie.quote }
  end
end