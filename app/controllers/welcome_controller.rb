class WelcomeController < ApplicationController
  skip_before_action :require_login, only: [:start]
  
  def start
  end
  
  def home
  end
  
  def testing
    @user = current_user
  end
end