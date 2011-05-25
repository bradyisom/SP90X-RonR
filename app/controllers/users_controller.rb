class UsersController < ApplicationController
  def index

  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @title = "Register"
  end
  
  def create
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end

end
