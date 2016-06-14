class UsersController < ApplicationController
  
  def my_friends
    @friendships = current_user.friends_except_pending
    @pending_friends = current_user.friends.invitation_not_accepted
  end
  
  def search
    @users = User.search(params[:search_param])
    
    if @users
      @users = current_user.except_current_user(@users)
      render partial: 'friends/lookup'
    else
      render status: :not_found, nothing: true
    end
  end

  def add_friend
    @friend = User.invite!(email: params[:email])
    current_user.friendships.build(friend_id: @friend.id)
    
    if current_user.save
      redirect_to my_friends_path, notice: "Friend was successfully added / invited."
    else
      redirect_to my_friends_path, flash[:error] = "There was an error with adding user as friend. Fuck knows why. :("
    end
  end
  
  def show
    @user = User.find(params[:id])
    
    @alternatives = current_user.alternative_proposed_for(@user)
    @requestable = current_user.requests_from(@user)
  end
  
end