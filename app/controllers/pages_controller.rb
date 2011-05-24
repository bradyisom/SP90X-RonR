class PagesController < ApplicationController
  def home
    @title = 'Home'
  end

  def about
    @title = 'About'
  end

  def donate
    @title = 'Donate'
  end

  def feedback
    @title = 'Feedback'
  end

  def resources
    @title = 'Resources'
  end

end
