def sign_in(user)
  visit root_path
  fill_in 'user_username', with: user.username
  fill_in 'user_password', with: user.password
  click_button 'Sign in'
end
