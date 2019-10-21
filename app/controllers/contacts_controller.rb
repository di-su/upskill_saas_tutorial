class ContactsController < ApplicationController 
  
  # GET request to /contact-us 
  # Show new contact form
  def new
    # Executed on /contacts/new visit 
    # Create a blank contact object {name: , email: , comments: }
    @contact = Contact.new
    # Then pull the new.html.erb view (default)
  end
  
  # POST request to /contacts
  def create
    # Mass assignment of form fields into contact object
    # Grab the form fields and assign them to the object
    # {name: example, email: example, comments: example}
    @contact = Contact.new(contact_params)
    # Save the Contact job to the database
    if @contact.save 
      # Store form fields via parameters, into variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      
      # Plug variables into Contact Mailer email method and send email
      ContactMailer.contact_email(name, email, body).deliver
      # Store success message in flash hash and redirect to the new action
      flash[:success] = "Message sent."
      redirect_to new_contact_path
    else 
      # If Contact object doesn't save, store errors in flash hash, and redirect to the new action
      flash[:danger] = @contact.errors.full_messages.join(", ")
      # {key: value, key: value}
      redirect_to new_contact_path
    end
  end
  
  # private = only to be used in this file
  private 
    # To collect data from from, we need to use strong parameters and whitelist the form fields
    def contact_params
      # Save securely to the DB 
      params.require(:contact).permit(:name, :email, :comments)
    end
end
