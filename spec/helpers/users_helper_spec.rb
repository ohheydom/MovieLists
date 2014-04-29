require 'spec_helper'

describe UsersHelper do
  describe 'add_most_recent_movies_and_ids_to_array(user, number)' do
    it 'creates an array of the most recent movies' do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:connector, user: user)
      FactoryGirl.create(:connector, movie_id: 238, user: user)
      FactoryGirl.create(:connector, movie_id: 278, user: user)
      expect(helper.add_most_recent_movies_and_ids_to_array(user, 3)).to eq([['Finding Nemo', 12],
                                                                             ['The Godfather', 238],
                                                                             ['The Shawshank Redemption', 278]])
    end
  end
end
