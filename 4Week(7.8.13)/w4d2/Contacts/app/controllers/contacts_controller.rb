class ContactsController < ApplicationController

  def index
    render json: User.find(params[:user_id]).contacts.order("name")
  end

  def create
    user = User.where(params[:user]).first_or_create
    listing = User.find(params[:user_id]).listings.build(contact_id: user.id)
    if listing.save
      render :json => listing.contact
    else
      render :json => listing.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: User.find(params[:user_id]).contacts.order("name")[params[:id].to_i]
  end

  def favorite
    user = User.find(params[:user_id])
    contact = user.contacts.order("name")[params[:contact_id].to_i]
    listing = Listing.find_by_user_id_and_contact_id(params[:user_id], contact.id)
    listing.favorite=true
    listing.save
    render json: user.contacts
  end

  def unfavorite
    user = User.find(params[:user_id])
    contact = user.contacts.order("name")[params[:contact_id].to_i]
    listing = Listing.find_by_user_id_and_contact_id(params[:user_id], contact.id)
    listing.favorite=false
    listing.save
    render json: user.contacts
  end

  def destroy
    user = User.find(params[:user_id])
    contact = user.contacts.order("name")[params[:id].to_i]
    Listing.find_by_user_id_and_contact_id(params[:user_id], contact.id).destroy
    render json: user.contacts
  end

end
