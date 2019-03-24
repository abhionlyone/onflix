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

class PurchaseSerializer
  include FastJsonapi::ObjectSerializer
  include ActionView::Helpers::DateHelper
  attributes :id, :expires_in, :expires_at

  attribute :order_info do |obj|
    {
      title: obj.content.title,
      type: obj.content.type,
      quality: obj.variant.quality,
      price: obj.variant.price_in_dollars,
      media: obj.content.media
    }
  end
end
