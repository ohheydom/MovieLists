class Movie < ActiveRecord::Base
has_many :connectors
has_many :profiles, through: :connectors
end
