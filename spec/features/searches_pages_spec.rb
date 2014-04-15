require 'spec_helper'

describe 'Search Pages' do
  subject { page }

  describe 'Index' do

    context 'Movie Search' do
      context 'Logged In', :js => true do
        let(:user) { FactoryGirl.create(:user) }
        let!(:user_movie) { FactoryGirl.create(:connector, user: user, movie_id: 4248) } #Scary Movie 2

        before do
          VCR.use_cassette 'search_spec/movie/scary_movie_logged_in' do
            sign_in user
            fill_in 'query', with: 'Scary Movie'
            click_button 'Search'
          end
        end

        it { should have_content('Scary Movie') }
        it { should have_css('.movie_unwatched') }

        describe "Clicking and Unclicking checkbox for move I haven't seen, Scary Movie" do
          it 'changes the user.movies count by 1 and reclicking changes by -1' do
              expect { wait; check('4247_button'); wait }.to change(user.movies, :count).by(1)
              expect { wait; uncheck('4247_button'); wait }.to change(user.movies, :count).by(-1)
          end
        end

        describe "Unclicking and clicking checkbox for movie I've seen, Scary Movie 2" do
          it 'changes the user.movies count by -1 and reclicking changes by 1' do
              expect { wait; uncheck('4248_button'); wait }.to change(user.movies, :count).by(-1)
              expect { wait; check('4248_button'); wait }.to change(user.movies, :count).by(1)
          end
        end
      end

      context 'Not Logged In' do
        before do
          VCR.use_cassette 'search_spec/movie/scary_movie_not_logged_in' do
            visit root_path
            fill_in 'query', with: 'Scary Movie'
            click_button 'Search'
          end
        end

        it { should have_content('Scary Movie') }
        it { should have_css('.noclass') }
      end
    end
  end

  context 'Actor Search' do
    before do
      VCR.use_cassette 'search_spec/actor/tom_cruise' do
        visit root_path
        choose 'Actor'
        fill_in 'query', with: 'Tom Cruise'
        click_button 'Search'
      end
    end

    it { should have_content('Tom Cruise') }
    it { should have_link('Tom Cruise', href: actor_path(500)) }
  end
end
