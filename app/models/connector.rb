class Connector < ActiveRecord::Base
belongs_to :movie
belongs_to :profile
end
