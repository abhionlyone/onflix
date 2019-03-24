# == Schema Information
#
# Table name: contents
#
#  id         :integer          not null, primary key
#  title      :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ContentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :type, :title

  attribute :variants do |obj|
    VariantSerializer.new(obj.variants)
  end
  
  attribute :assets do |obj|
    AssetSerializer.new(obj.assets)
  end
end
