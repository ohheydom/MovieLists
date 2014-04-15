WAIT_TIME = 1
def sign_in(user)
  visit root_path
  fill_in 'user_username', with: user.username
  fill_in 'user_password', with: user.password
  click_button 'Sign in'
end

def wait(time = WAIT_TIME)
  sleep(inspection_time = time)
end
