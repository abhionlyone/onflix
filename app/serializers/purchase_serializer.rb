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
