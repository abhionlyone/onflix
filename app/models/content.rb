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

class Content < ApplicationRecord
  has_many :assets
  has_many :variants
  default_scope { order(created_at: :asc) }

  def media
    type == "Movie" ? playback : episodes
  end

end
