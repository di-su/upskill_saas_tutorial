class ContactsController < ApplicationController 
  def new
    # Executed on /contacts/new visit 
    # Create a blank contact object {name: , email: , comments: }
    @contact = Contact.new
    # Then pull the new.html.erb view (default)
  end
  
  def create
    # Grab the form fields and assign them to the object
    # {name: example, email: example, comments: example}
    @contact = Contact.new(contact_params)
    if @contact.save 
      redirect_to new_contact_path, notice: "Message sent."
    else 
      redirect_to new_contact_path, notice: "Error occured."
    end
  end
  
  # private = only to be used in this file
  private 
    def contact_params
      # Save securely to the DB 
      params.require(:contact).permit(:name, :email, :comments)
    end
end
