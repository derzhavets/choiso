class WelcomeController < ApplicationController
  skip_before_action :require_login, only: [:start]
  
  def start
  end
  
  def home
  end
end