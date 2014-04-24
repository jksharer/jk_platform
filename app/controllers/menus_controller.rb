class MenusController < ApplicationController
  before_action :authorize
  before_action :set_menu, only: [:show, :edit, :update, :destroy]
  
  def index
    @menus = Menu.where(parent_menu_id: nil).order('display_order asc')
  end

  def show
  end

  def new
    @menu = Menu.new
  end

  def edit
  end

  def create
    @menu = Menu.new(menu_params)

    respond_to do |format|
      if @menu.save
        format.html { redirect_to menus_url, 
          notice: 'Menu was successfully created.' }
        format.json { render action: 'show', 
          status: :created, location: @menu }
      else
        format.html { render action: 'new' }
        format.json { render json: @menu.errors, 
          status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to menus_url, 
          notice: 'Menu was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @menu.errors, 
          status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to menus_url }
      format.json { head :no_content }
    end
  end

  private
    def set_menu
      @menu = Menu.find(params[:id])
    end

    def menu_params
      ps = params.require(:menu).permit(:name, :url, :parent_menu, :status, :display_order)
      ps[:parent_menu] = Menu.find_by(name: ps[:parent_menu])
      return ps
    end
end