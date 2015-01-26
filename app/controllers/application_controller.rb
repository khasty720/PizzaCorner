class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #Devise Strong Params
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  if Rails.env.development?
    # https://github.com/RailsApps/rails-devise-pundit/issues/10
    #include Pundit
    # https://github.com/elabs/pundit#ensuring-policies-are-used
    #after_action :verify_authorized,  except: :index
    #after_action :verify_policy_scoped, only: :index

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private
    def user_not_authorized
      flash[:alert] = "Access denied." # TODO: make sure this isn't hard coded English.
      redirect_to (request.referrer || root_path) # Send them back to them page they came from, or to the root page.
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) #<< :role
    end
  end

end
