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
  after_create :clear_cache

  def media
    type == "Movie" ? playback : episodes
  end

  def self.cached_results
    Rails.cache.fetch(["content"], expires_in: 5.minutes) do
      includes(:assets, :variants).order(created_at: :asc)
    end
  end

  private

  def clear_cache
    Rails.cache.delete("content")
    Rails.cache.delete("seasons")
    Rails.cache.delete("movies")
  end
end
