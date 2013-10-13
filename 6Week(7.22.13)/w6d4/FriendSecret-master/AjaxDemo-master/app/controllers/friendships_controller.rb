class FriendshipsController < ApplicationController

  def create
    friendship = current_user.friendships.build(friend_id: params[:user_id])
    friendship.save

    redirect_to current_user
  end

  def destroy
    friendship = Friendship.find_by_user_id_and_friend_id(current_user.id, params[:user_id])
    friendship.destroy


    # render :json => User.all
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { render :json => User.all }
    end
  end
end
