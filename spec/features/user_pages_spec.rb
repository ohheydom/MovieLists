require 'spec_helper'

describe 'User Pages' do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user, username: 'other_user', email: 'other_user@other.com') }
  let!(:connector) { FactoryGirl.create(:connector, user: user) }
  let!(:other_connector) { FactoryGirl.create(:connector, user: other_user) }
  let!(:another_connector) { FactoryGirl.create(:connector, user: other_user, movie_id: 238) }

  before do
    sign_in user
  end

  describe 'Profile Page' do
    before { visit root_path }

    it { should have_title(user.username) }

    describe 'Statistics' do
      it { should have_content('Number of movies') }
      it { should have_content('Top Five actors/actresses') }
      it { should have_content('watched the most movies made in') }
      it { should have_content('Recently Added Movies') }
      it { should have_content('Other Users') }
      it { should have_content(Movie.find(connector.movie_id).title) }
    end
  end

  describe "Other User's Profile Page", :js => true do
    before { visit profile_path(other_user) }

    it { should have_title(other_user.username) }
    it { should have_content(Movie.find(other_connector.movie_id).title) }
    it { should have_content(Movie.find(another_connector.movie_id).title) }
    it { should have_css('.movie_watched') }
    it { should have_css('.movie_unwatched') }
    it { should have_css('table.percentage_of_movies') }

    describe "Unclicking and Clicking checkbox for movie I've seen, Finding Nemo" do
      it 'changes the user.movies count by 1 and reclicking changes by -1' do
        VCR.use_cassette 'movies_spec/finding_nemo' do
          expect { uncheck('12_button') }.to change(user.movies, :count).by(-1)
        end
        VCR.use_cassette 'movies_spec/finding_nemo' do
          expect { check('12_button') }.to change(user.movies, :count).by(1)
        end
      end
    end

    describe "Clicking and Unclicking checkbox for movie I haven't seen, The Godfather" do
      it 'changes the user.movies count by -1 and reclicking changes by 1' do
        VCR.use_cassette 'movies_spec/the_godfather' do
          expect { check('238_button') }.to change(user.movies, :count).by(1)
        end
        VCR.use_cassette 'movies_spec/the_godfather' do
          expect { uncheck('238_button') }.to change(user.movies, :count).by(-1)
        end
      end
    end
  end
end
