require 'rails_helper'

describe SettingsController do
  describe '#save_movie_list' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:user_movie) { FactoryGirl.create(:connector, user: user, movie_id: 10023) }
    let(:csv_string) { user.movies.to_csv }
    let(:csv_arguments) {  { filename: 'my_movies.csv' } }

    before do
      sign_in user
    end

    it 'returns a csv attachment' do
      expect(@controller).to receive(:send_data).with(csv_string, csv_arguments)
      .and_return {@controller.render text: true }
      post :save_movie_list, user_id: user.username
    end
  end
end
