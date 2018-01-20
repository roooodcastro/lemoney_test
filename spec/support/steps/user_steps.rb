module UserSteps
  # Signs in the user manually, by going to the log in page, filling out the
  # form and submitting it.
  def sign_in_manually(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
