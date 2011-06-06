module SessionsHelper
  
  def login(user)
    cookies.signed[:login_token] = {
      :value => [user.id, user.salt],
      :expires => 1.day.from_now
    }
    self.current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user || user_from_login_token
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def deny_access
    store_location
    redirect_to login_path, :notice => "Please sign in to access this page."
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  
  def logout
    cookies.delete(:login_token)
    self.current_user = nil
  end
  
private
  
  def user_from_login_token
    User.authenticate_with_salt(*login_token)
  end
  
  def login_token
    cookies.signed[:login_token] || [nil, nil]
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end
  
  def clear_return_to
    session[:return_to] = nil
  end
    
end
