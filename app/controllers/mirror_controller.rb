class MirrorController < ApplicationController
  def index
    @user = current_user
    @strengths = current_user.strengths
    @weaknesses = current_user.weaknesses
  end
end