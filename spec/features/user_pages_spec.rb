require 'spec_helper'

describe "User Pages" do
  subject { page }
  
  describe "Profile Page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:connector) { FactoryGirl.create(:connector, user: user) }
    before do
      sign_in user
      visit root_path
    end

    it { should have_title(user.username) }

    describe "Statistics" do
      it { should have_content("Number of movies") }
      it { should have_content("Top Five actors/actresses") }
      it { should have_content("watched the most movies made in") }
      it { should have_content(Movie.find(connector.movie_id).title) }
    end
  end
end
