require 'spec_helper'

describe "Search Pages" do
  subject { page }

  describe "Index" do

    context "Movie Search" do
      context "Logged In" do
        let(:user) { FactoryGirl.create(:user) }
        let!(:user_movie) { FactoryGirl.create(:connector, user: user, movie_id: 4248) } #Scary Movie 2

        before do
          VCR.use_cassette 'search_spec/movie/scary_movie' do
            sign_in user
            fill_in "query", with: "Scary Movie"
            click_button "Search"
          end
        end 

        it { should have_content("Scary Movie") }
        it { should have_css(".movie_unwatched") }
        
        describe "clicking I've seen it button for Scary Movie" do
          it "changes the user.movies count by 1 and reclicking changes by -1" do
            VCR.use_cassette 'movies_spec/scary_movie' do
              expect{ click_button("4247_button") }.to change(user.movies, :count).by(1)
            end
            VCR.use_cassette 'movies_spec/scary_movie' do
              expect{ click_button("4247_button") }.to change(user.movies, :count).by(-1)
            end
          end
        end

        describe "clicking I've seen it button for Scary Movie 2" do
          it "changes the user.movies count by -1 and reclicking changes by 1" do
            VCR.use_cassette 'movies_spec/scary_movie_2' do
              expect{ click_button("4248_button") }.to change(user.movies, :count).by(-1)
            end
            VCR.use_cassette 'movies_spec/scary_movie_2' do
              expect{ click_button("4248_button") }.to change(user.movies, :count).by(1)
            end
          end
        end
      end

      context "Not Logged In" do
        before do
          VCR.use_cassette 'search_spec/scary_movie' do
            visit root_path
            fill_in "query", with: "Scary Movie"
            click_button "Search"
          end
        end

      it { should have_content("Scary Movie") }
      it { should have_css(".noclass") }
      end
    end
  end

  context "Actor Search" do
    before do
      VCR.use_cassette 'search_spec/actor/tom_cruise' do
        visit root_path
        choose "Actor"
        fill_in "query", with: "Tom Cruise"
        click_button "Search"
      end
    end

    it { should have_content("Tom Cruise") }
    it { should have_link("Tom Cruise", href: actor_path(500)) }
  end
end
