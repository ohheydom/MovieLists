class Movie < ActiveRecord::Base
  serialize :actors

  has_many :connectors
  has_many :users, through: :connectors

  validates :id, uniqueness: true
end
