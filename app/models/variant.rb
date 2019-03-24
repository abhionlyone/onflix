# == Schema Information
#
# Table name: variants
#
#  id         :integer          not null, primary key
#  price      :float
#  quality    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  content_id :integer
#
# Indexes
#
#  index_variants_on_content_id  (content_id)
#

class Variant < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  belongs_to :content

  def price_in_dollars
    number_to_currency price
  end
end
