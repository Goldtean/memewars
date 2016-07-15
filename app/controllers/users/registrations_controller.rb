class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
    before_filter :configure_permitted_parameters, if: :devise_controller?


  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    @user = User.new(params[:user].permit(:first_name, :last_name, :street_address, :city, :state, :zip_code, :cell_phone, :email, :password, :username))
    respond_to do |format|
      if @user.save
        # MailWorker.perform_in(1.minute, @user.id)
        format.html { redirect_to root_path }
        format.json { redirect_to root_path }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :current_password])

    # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :current_password) }
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << :attribute
  end

  def after_sign_up_path_for(resource)
    sign_in(resource_name, resource)
  end

end
