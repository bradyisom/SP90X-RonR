class UsersController < ApplicationController
  def index

  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @title = "Register"
    @user = User.new;
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Registration Successful! Welcome to SP90X!"
      redirect_to @user
    else
      @title = "Register"
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end

end
