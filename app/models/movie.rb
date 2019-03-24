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
    {
      movie_playback: assets.first
    }
  end
end
