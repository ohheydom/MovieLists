class Movie < ActiveRecord::Base
  serialize :actors

  has_many :connectors
  has_many :users, through: :connectors

  validates :id, uniqueness: true

  def self.by_year_or_all(year=nil)
    year ? where(year: year) : all
  end

end
