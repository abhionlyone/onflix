# == Schema Information
#
# Table name: contents
#
#  id         :integer          not null, primary key
#  price      :float
#  quality    :string
#  title      :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Season < Content
end
