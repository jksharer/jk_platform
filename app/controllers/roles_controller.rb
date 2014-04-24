class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  def index
    @roles = Role.all
  end

  def show
  end

  def new
    @role = Role.new
    @menus = Menu.where(parent_menu_id: nil).order('display_order asc')
  end

  def edit
    @menus = Menu.where(parent_menu_id: nil).order('display_order asc')
  end

  def create
    @role = Role.new(role_params)
    @role.menu_ids = params[:menus_of_role]
    respond_to do |format|
      if @role.save
        format.html { redirect_to roles_url, 
          notice: 'Role was successfully created.' }
        format.json { render action: 'show', 
          status: :created, location: @role }
      else
        format.html { render action: 'new' }
        format.json { render json: @role.errors, 
          status: :unprocessable_entity }
      end
    end
  end

  def update
    @role.menu_ids = params[:menus_of_role]
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to roles_url, 
          notice: 'Role was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @role.errors, 
          status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @role.menus.clear
    @role.users.clear
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url }
      format.json { head :no_content }
    end
  end

  private
    def set_role
      @role = Role.find(params[:id])
    end

    def role_params
      params.require(:role).permit(:name)
    end
end