class Movie < ActiveRecord::Base
  serialize :actors

  has_many :connectors
  has_many :users, through: :connectors

  validates :id, uniqueness: true

  def self.by_year_or_all(release_date = nil)
    valid_years = (1900..2040).to_a
    release_date && valid_years.include?(year.to_i) ? where(release_date: release_date) : all
  end
end
