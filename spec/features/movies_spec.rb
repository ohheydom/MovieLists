require 'spec_helper'

describe "Movie Page" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  let!(:user_movie) { FactoryGirl.create(:connector, user: user, movie_id: 12) }
  before do
    VCR.use_cassette 'movies_spec/watched_film' do
      sign_in user
      visit movie_path(user_movie.movie_id) 
    end
  end

  it { should have_title(Movie.find(user_movie.movie_id).title) }

  describe "clicking I haven't seen it button" do
    before do 
      VCR.use_cassette 'movies_spec/watched_film' do  
        visit movie_path(user_movie.movie_id)
      end
    end

    it { should have_css('tr.movie_watched') }

    it "changes the user's movies by -1" do
      VCR.use_cassette 'movies_spec/watched_film' do
        expect{ click_button "Oops, I haven't seen it!"}.to change(user.movies, :count).by(-1)
      end
      VCR.use_cassette 'movies_spec/watched_film' do
        expect{ click_button "I've seen it!" }.to change(user.movies, :count).by(1)
      end
    end
  end

  describe "clicking I've seen it button" do
    before do
      VCR.use_cassette 'movies_spec/unwatched_film' do
        visit movie_path(13)
      end
    end
    
    it { should have_css('tr.movie_unwatched') }


    it "changes the user's movies by 1" do
      VCR.use_cassette 'movies_spec/unwatched_film' do
        expect{ click_button "I've seen it!" }.to change(user.movies, :count).by(1)
      end
      VCR.use_cassette 'movies_spec/unwatched_film' do
        expect{ click_button "Oops, I haven't seen it!"}.to change(user.movies, :count).by(-1)
      end
    end
  end
end
