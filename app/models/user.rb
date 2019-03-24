# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  tokens                 :text
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable  
  include DeviseTokenAuth::Concerns::User
 
  has_many :purchases

  def library
    Rails.cache.fetch(["user_library_#{id}"], expires_in: 5.minutes) do
      purchases.alive
    end
  end

  def expire_library_cache
    Rails.cache.delete "user_library_#{id}"
  end

  def create_token
    random = SecureRandom.urlsafe_base64(nil, false)
    self.token = BCrypt::Password.create(random)
    self.save!
    random
  end

  def validate_token?(tok)
    BCrypt::Password.new(token) == tok
  end

end
