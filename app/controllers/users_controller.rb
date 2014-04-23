class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.role_ids = params[:roles_of_user]

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, 
          notice: 'User was successfully created.' }
        format.json { render action: 'show', 
          status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, 
          status: :unprocessable_entity }
      end
    end
  end

  def update
    @user.role_ids = params[:roles_of_user]
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, 
          notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.roles.clear
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      ps = params.require(:user).permit(:username, :password, :password_confirmation, :agency)
      ps[:agency] = Agency.find_by(name: ps[:agency])
      return ps
    end
end