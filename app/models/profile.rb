class Profile < ActiveRecord::Base
has_many :connectors
has_many :movies, through: :connectors
end
