require 'spec_helper'

describe 'List Pages' do
  subject { page }

  describe 'Index' do
  end

  describe 'Show' do
    let(:top_250) { '522effe419c2955e9922fcf3' }

    context 'Logged In', :js => true do
      let(:user) { FactoryGirl.create(:user) }
      let!(:user_movie) { FactoryGirl.create(:connector, user: user, movie_id: 238) }

      before do
        VCR.use_cassette 'lists_spec/top250' do
          sign_in user
          visit list_path(top_250)
        end
      end

      it { should have_title('IMDb Top 250') }
      it { should have_css('.movie_unwatched') }

      describe "Clicking and Unclicking checkbox for movie I haven't seen, The Godfather" do
        it 'changes the user.movies count by -1 and reclicking changes by 1' do
          VCR.use_cassette 'movies_spec/the_godfather' do
            expect { uncheck_and_wait('238_button') }.to change(user.movies, :count).by(-1)
            expect { check_and_wait('238_button') }.to change(user.movies, :count).by(1)
          end
        end
      end

      describe "Unclicking and clicking checkbox for movie I've seen, Pulp Fiction" do
        it 'changes the user.movies count by 1 and reclicking changes by -1' do
          VCR.use_cassette 'movies_spec/pulp_fiction' do
            expect { check_and_wait('680_button') }.to change(user.movies, :count).by(1)
            expect { uncheck_and_wait('680_button') }.to change(user.movies, :count).by(-1)
          end
        end
      end
    end

    context 'Not Logged In' do
      before do
        VCR.use_cassette 'lists_spec/top250' do
          visit list_path(top_250)
        end
      end

      it { should have_title('IMDb Top 250') }
      it { should have_css('.noclass') }
    end
  end
end
