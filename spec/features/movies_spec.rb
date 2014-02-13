require 'spec_helper'

describe "Movie Page" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  let!(:user_movie) { FactoryGirl.create(:connector, user: user, movie_id: 12) }
  before do
    sign_in user
    visit movie_path(user_movie.movie_id) 
  end

  it { should have_title(Movie.find(user_movie.movie_id).title) }

  describe "clicking I haven't seen it button" do
    before { visit movie_path(user_movie.movie_id) }

    it { should have_css('tr.movie_watched') }

    it "changes the user's movies by -1" do
      expect{ click_button "Oops, I haven't seen it!"}.to change(user.movies, :count).by(-1)
      expect{ click_button "I've seen it!" }.to change(user.movies, :count).by(1)
    end

  end

  describe "clicking I've seen it button" do
    before { visit movie_path(13) }
    
    it { should have_css('tr.movie_unwatched') }


    it "changes the user's movies by 1" do
      expect{ click_button "I've seen it!" }.to change(user.movies, :count).by(1)
      expect{ click_button "Oops, I haven't seen it!"}.to change(user.movies, :count).by(-1)
    end
  end
end
