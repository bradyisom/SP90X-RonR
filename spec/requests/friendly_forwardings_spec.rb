require 'spec_helper'

describe "FriendlyForwardings" do
  it "should forward to the requested page after login" do
    user = Factory(:user)
    visit edit_user_path(user)
    fill_in :username, :with => user.username
    fill_in :password, :with => user.password
    click_button
    response.should render_template('users/edit')
  end
end
