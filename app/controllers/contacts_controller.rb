class ContactsController < ApplicationController
  def new
  end

  def thanks
    ContactMailer.contact(params[:email], params[:content]).deliver
  end
end
