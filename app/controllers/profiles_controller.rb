class ProfilesController < ApplicationController
  
  # Use devise action "authenticate_user" to make a rule
  # that users cannot access ANY page in the profiles
  # controller unless the user is authenticated / has a 
  # valid account.
  before_action :authenticate_user!
  
  # Only the current user should have access to their own
  # pages below and not other users'.
  before_action :only_current_user
  
  def new
    # form for user profile content
    
    # Look in the database and find the user who is logged in.
    @user = User.find(params[:user_id])
    
    # Once the user is found, build a profile for that user
    # using "Profile.new." We're avoiding build_profile
    # because we don't want a new profile created every
    # time a user visits a new profile.
    @profile = Profile.new
  end
  
  def create
    # Look in the database and find the user who is logged in.
    @user = User.find(params[:user_id])
    
    # Once the user is found, build a profile for that user
    # using "build_profile" which is a Rails built-in method.
    # Pass in whatever the user inputs in their profile update
    # form.
    @profile = @user.build_profile(profile_params)
    
    # If everything passes validation and the profile saves,
    if @profile.save
      # Redirect to the user's show page.
      redirect_to user_path(params[:user_id])
    else
      render action: :new 
    end
  end
  
  def edit
    
    # Look in the database and find the user who is logged in.
    @user = User.find(params[:user_id])
    
    # Grab the profile that the user has created.
    @profile = @user.profile
  end
  
  def update
    # Look in the database and find the user who is logged in.
    @user = User.find(params[:user_id])
    
    # Grab the profile that the user has created.
    @profile = @user.profile
    
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated"
      redirect_to user_path(params[:user_id])
    else
      render action: :edit
    end
  end
  
  # Whitelist the form fields to make them accessible.
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :job_title, :avatar, :description, :contact_email, :phone_number)
    end
    
    def only_current_user
      # Look in the database and find the user who is logged in.
      @user = User.find(params[:user_id])
      
      # Redirect the user who tries to access a page that is not
      # theirs.
      redirect_to(root_url) unless @user == current_user
    end
end