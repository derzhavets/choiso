class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @friend = User.invite!(email: friendship_params[:friend])
    current_user.friendships.new(user: current_user, friend: @friend)
    
    if current_user.save
      respond_to do |format|
        #format.html { redirect_to my_friends_path, notice: "Right here" }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to my_friends_path, notice: "Something WRONG" }
      end
    end
  end
  
    
  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]).first
    @friendship.destroy
    
    respond_to do |format|
    format.html { redirect_to my_friends_path, notice: "Friend was successfully removed"}
    end
  end
  
  private
  
  def friendship_params
    params.require(:friendship).permit(:friend)
  end
  
end