require 'csv'
class Movie < ActiveRecord::Base
  serialize :actors

  has_many :connectors, dependent: :destroy
  has_many :users, through: :connectors

  validates :id, uniqueness: true

  def self.by_year_or_all(release_date = nil)
    valid_years = (1900..2040).to_a
    release_date && valid_years.include?(release_date.to_i) ? where(release_date: release_date) : all
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << %w(title)
      pluck(:title).sort.each { |title| csv << [title] }
    end
  end
end
