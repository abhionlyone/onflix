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

class Movie < Content
  def playback
    Rails.cache.fetch(["movie_playback_#{id}"], expires_in: 5.minutes) do
      {
        movie_playback: assets.first
      }
    end
  end

  def self.cached_results
    Rails.cache.fetch(["movies"], expires_in: 5.minutes) do
      includes(:assets, :variants).order(created_at: :asc)
    end
  end
end
