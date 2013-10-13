class NotesController < ApplicationController
  before_filter :authenticate_user

  def create
    note = Note.new(params[:note])
    note.user_id = current_user.id
    if note.save
      redirect_to track_url(note.track_id)
    else
      flash[:errors] = note.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    note = Note.find(params[:id])
    track_id = note.track_id
    note.destroy
    redirect_to track_url(track_id)
  end
end
