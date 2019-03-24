# == Schema Information
#
# Table name: assets
#
#  id              :integer          not null, primary key
#  sequence_number :integer          default(1)
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  content_id      :integer
#
# Indexes
#
#  index_assets_on_content_id  (content_id)
#

class AssetSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title
end
