class SessionsController < ApplicationController
  def new
    @title = "Login"
    @content_width = 250;
  end

  def create
    user = User.authenticate(params[:session][:username], params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid username/password"
      @title = "Login"
      @content_width = 250;
      render 'new'
    else
      login user
      redirect_back_or user
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

end
