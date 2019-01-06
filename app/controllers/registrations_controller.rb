#from devise docs...

# class Users::SessionsController < Devise::SessionsController
#   def create
#     # custom sign-in code
#   end
# end

#sign_in (Devise::SessionsController#create) - Permits only the authentication keys (like email)
#sign_up (Devise::RegistrationsController#create) - Permits authentication keys plus password and password_confirmation
#account_update (Devise::RegistrationsController#update) - Permits authentication keys plus password, password_confirmation and current_password

class RegistrationsController < Devise::RegistrationsController
  
  def sign_up_params
    params.require(:user).permit(
      :first_name, 
      :last_name, 
      :email,
      :password,
      :password_confirmation, 
      :phone, 
      :shipping_address, 
      :billing_address
      )
  end

  def account_update_params
    params.require(:user).permit(
      :first_name, 
      :last_name, 
      :email,
      :password,
      :password_confirmation, 
      :current_password,
      :phone, 
      :shipping_address, 
      :billing_address
    )
  end
end
