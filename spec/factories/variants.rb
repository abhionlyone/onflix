require 'faker'

FactoryGirl.define do
  factory :variant do
    quality {["HD", "SD"].sample}
    price {rand(100)}
    content_id nil
  end
end