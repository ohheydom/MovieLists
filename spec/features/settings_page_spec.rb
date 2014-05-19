require 'spec_helper'

describe 'Settings Page' do
  describe '#show' do
    let(:user) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user, email: 'fakeemail@email.com', username: 'fakeuser') }

    before do
      sign_in user
      visit user_settings_path(user)
    end

    it "redirects to the current user's settings page if visiting another user's settings page" do
      visit user_settings_path(user2)
      expect(page).to have_content user.username
    end

    it 'has a button to save a users movie list' do
      expect(page).to have_button 'Save'
    end
  end
end
