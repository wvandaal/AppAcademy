class SecretsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index }
      format.json { render :json => Secret.all }
    end
  end

  def create
    params[:secret][:recipient_id] = params[:user_id]
    @secret = current_user.authored_secrets.build(params[:secret])

    @secret.save!

    respond_to do |format|
      format.html { redirect_to user_url(current_user)}
      format.json { render :json => @secret }
    end
  end

end
