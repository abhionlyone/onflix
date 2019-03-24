class VariantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :price, :quality
end
