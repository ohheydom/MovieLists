require 'spec_helper'

describe ProfilePage do
  describe '#most_recent_movies' do
    it 'creates an array of the most recent movies' do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:connector, user: user)
      FactoryGirl.create(:connector, movie_id: 238, user: user)
      FactoryGirl.create(:connector, movie_id: 278, user: user)

      expect(ProfilePage.new(user, nil, nil).most_recent_movies(5)).to eq([
        ['The Shawshank Redemption', 278],
        ['The Godfather', 238],
        ['Finding Nemo', 12]
      ])
    end
  end
end
