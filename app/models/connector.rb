class Connector < ActiveRecord::Base
belongs_to :movie
belongs_to :user

validates_uniqueness_of :user_id, scope: :movie_id

scope :all_user_movies, ->(user_id) { where("user_id = ?", user_id) }
end
