class PurchaseSerializer
  include FastJsonapi::ObjectSerializer
  include ActionView::Helpers::DateHelper
  attributes :id, :expires_in

  attribute :item do |obj|
    obj.content.title
  end
end
