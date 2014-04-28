def sign_in(user)
  visit root_path
  fill_in 'user_username', with: user.username
  fill_in 'user_password', with: user.password
  click_button 'Sign in'
end

def check_and_wait(checkbox)
  check checkbox
  wait_for_ajax
end

def uncheck_and_wait(checkbox)
  uncheck checkbox
  wait_for_ajax
end
