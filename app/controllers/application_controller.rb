class ApplicationController < ActionController::Base
    # like a hook
    # allows us to add code that will run before all controller actions in this controller
    # if in application controller, going to run before every action
    # check if we are in controller where devise is a helper
    before_action :configure_permitted_parameters, if: :devise_controller?
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    def not_found
        flash[:error] = "Not found"
        redirect_to students_path
    end 
  
end

