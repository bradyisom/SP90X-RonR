class UsersController < ApplicationController
  before_filter :authenticate, :except => [:new, :create]
  before_filter :correct_user, :except => [:new, :create]
  
  # def index
  # end
  
  def show
    @title = "#{@user.display_name}"
  end
  
  def new
    @title = "Register"
    @user = User.new;
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      login @user
      flash[:success] = "Registration Successful! Welcome to SP90X!"
      redirect_to @user
    else
      @title = "Register"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit Profile"
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit Profile"
      @user.reload
      render 'edit'
    end
  end
  
  # def destroy
  # end
  
private

  def authenticate
    deny_access unless logged_in?
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

end
