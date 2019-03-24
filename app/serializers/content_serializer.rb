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
