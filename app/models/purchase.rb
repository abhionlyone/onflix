# == Schema Information
#
# Table name: purchases
#
#  id         :integer          not null, primary key
#  expires_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  content_id :integer
#  user_id    :integer
#  variant_id :integer
#
# Indexes
#
#  index_purchases_on_content_id  (content_id)
#  index_purchases_on_user_id     (user_id)
#  index_purchases_on_variant_id  (variant_id)
#

class Purchase < ApplicationRecord
  include ActionView::Helpers::DateHelper

  belongs_to :user
  belongs_to :content
  belongs_to :variant

  before_create :set_expires_at

  scope :alive, lambda { where("expires_at > ?", Time.now) }
  scope :dead, lambda { where("expires_at < ?", Time.now) }

  validate :is_not_a_duplicate_purchase, on: :create

  def expires_in
    distance_of_time_in_words(self.expires_at, Time.now)
  end

  def is_not_a_duplicate_purchase
    if self.user.purchases.alive.where(content: self.content).first
      errors.add(:base, "You've already purchased this item.")
    end
  end


  private

  def set_expires_at
    self.expires_at = Time.now + 2.days
  end

end
