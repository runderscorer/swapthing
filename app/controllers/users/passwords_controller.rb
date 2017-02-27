class Users::PasswordsController < Devise::PasswordsController
  
   def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if resource.errors.any? 
      flash[:error] = 'Bummer. There was a problem with your email address.'
      redirect_to forgot_password_path
    else
      flash[:notice] = "Hang tight - A password reset has been sent to #{resource.email}"
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    end
  end
end
