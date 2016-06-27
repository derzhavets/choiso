class MirrorController < ApplicationController
  def index
    @user = current_user
    @strengths = current_user.own_strengths
    @weaknesses = current_user.own_weaknesses
    user_session.set_showable("strengths")
  end
end