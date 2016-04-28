class ContactsController < ApplicationController
  def new
    @contact = Contact.new        # Create object in server memory (blank contact object)
  end
  
  def create
  end
end