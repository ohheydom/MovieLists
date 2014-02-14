require 'spec_helper'

describe "Actor Page", :js => true do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let!(:user_movie) { FactoryGirl.create(:connector, user: user, movie_id: 10023) } #Dragnet

  before(:all) { Rails.cache.clear }
  before do
    VCR.use_cassette 'actors_spec/tom_hanks' do
      sign_in user
      visit actor_path(31)
    end
  end

  it { should have_title("Tom Hanks") }

  describe "Clicking and Unclicking checkbox for Movie I haven't seen, The Money Pit" do
    it "changes the user.movies count by 1 and reclicking changes by -1" do
      VCR.use_cassette 'movies_spec/the_money_pit' do
        expect{ check("10466_button") }.to change(user.movies, :count).by(1)
      end
      VCR.use_cassette 'movies_spec/the_money_pit' do
        expect{ uncheck("10466_button") }.to change(user.movies, :count).by(-1)
      end
    end
  end

  describe "Unclicking and clicking checkbox for movie I've seen, Dragnet" do
    it "changes the user.movies count by -1 and reclicking changes by 1" do
      VCR.use_cassette 'movies_spec/dragnet' do
        expect{ uncheck("10023_button") }.to change(user.movies, :count).by(-1)
      end
      VCR.use_cassette 'movies_spec/dragnet' do
        expect{ check("10023_button") }.to change(user.movies, :count).by(1)
      end
    end
  end
end
