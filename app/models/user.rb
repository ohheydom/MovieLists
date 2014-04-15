class User < ActiveRecord::Base
  include DeviseConcerns
  has_one :profile
  has_many :connectors, dependent: :destroy
  has_many :movies, through: :connectors

  validates :username, presence: true, uniqueness: true, format: { without: /\A\d/ }, length:
            { maximum: 12, too_long: "%{count} characters is the maximum allowed" }
end
