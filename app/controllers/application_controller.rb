class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #--- Helper current order ---
  helper_method :current_order


  #Devise Strong Params
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)

    #---- Get Admin User -----
    @admin = User.first
    #-------------------------

    #Links for Nav Bar
    @category_links = Category.all
    #-------------------------
    end




    private
    def user_not_authorized
      flash[:alert] = "Access denied." # TODO: make sure this isn't hard coded English.
      redirect_to (request.referrer || root_path) # Send them back to them page they came from, or to the root page.
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :company << :street << :city <<:state << :zip << :country
      devise_parameter_sanitizer.for(:account_update) << :company << :street << :city <<:state << :zip << :country
    end

    def current_order
      if !session[:order_id].nil?
        Order.find(session[:order_id])
      else
        Order.new
      end
    end

end
