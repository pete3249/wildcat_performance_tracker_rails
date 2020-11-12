class ApplicationController < ActionController::Base
    # like a hook that allows us to add code that will run before all controller actions in this controller
    # if in application controller, going to run before every action
    # check if we are in controller where devise is a helper
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
    end
  
end

