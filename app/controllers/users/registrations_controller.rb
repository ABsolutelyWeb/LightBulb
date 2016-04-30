# This file overrides Devise's default parameters.
class Users::RegistrationsController < Devise::RegistrationsController
  # Run the filter function select_plan before any of the code below is run.
  before_filter :select_plan, only: :new
  
  
  def create
    # Import create action code
    super do |resource|
  
      # When user submits either form, grab the form and check to see
      # if a parameter plan is in there (it should be).
      if params[:plan]
  
        # if so, save that value inside resource.plan_id.
        resource.plan_id = params[:plan]
  
        # Then if the plan id of the user is the premium option,
        if resource.plan_id === 2
  
          # then save that form while keeping in mind user's plan_id
          # and then charge their account for payment. save_with_payment
          # is defined in user.db under models.
          resource.save_with_payment
        else
  
          # if they have the free account, save as usual.
          resource.save
        end
      end
    end
  end
  
  private
    # This function is to prevent a user from entering in an 
    def select_plan
      unless params[:plan] && (params[:plan] == '1' || params[:plan] == '2')
        redirect_to root_url
      end
    end
end