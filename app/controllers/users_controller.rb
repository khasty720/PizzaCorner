class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    unless @admin == current_user
      redirect_to root_path, :alert => "Access denied."
    end
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user || @admin == current_user
      redirect_to root_path, :alert => "Access denied."
    end
  end

  def edit
    unless @admin == current_user
      redirect_to root_path, :alert => "Access denied."
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    if @admin == current_user
      @user.destroy
      respond_to do |format|
        format.html { redirect_to categories_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path, :alert => "Access denied."
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email,:first_name, :last_name, :street, :city, :state, :zip, :country, :employee)
  end

end
