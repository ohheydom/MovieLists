require 'spec_helper'

describe "Actor Page" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  let!(:user_movie) { FactoryGirl.create(:connector, user: user, movie_id: 10023) } #Dragnet
  before do
    sign_in user
    visit actor_path(31)
  end

  it { should have_title("Tom Hanks") }

  describe "clicking I've seen it button for The Money Pit" do
    it "changes the user.movies count by 1 and reclicking changes by -1" do
    expect{ click_button("10466_button") }.to change(user.movies, :count).by(1)
    expect{ click_button("10466_button") }.to change(user.movies, :count).by(-1)
    end
  end

  describe "clicking I haven't seen it button for Dragnet" do
    it "changes the user.movies count by -1 and reclicking changes by 1" do
    expect{ click_button("10023_button") }.to change(user.movies, :count).by(-1)
    expect{ click_button("10023_button") }.to change(user.movies, :count).by(1)
    end
  end
end
