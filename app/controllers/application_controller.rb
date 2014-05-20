class ApplicationController < ActionController::Base
  include SessionsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :detect_device_type
  before_action :set_two_level_menus
 
  def set_two_level_menus
    if params[:parent]
      @two_level_menus = current_user.sub_menus(Menu.find_by(name: params[:parent])) 
      @current_menu = Menu.find_by(name: params[:parent]) 
    elsif params[:menu_id]
      # menu = Menu.find(params[:menu_id]).parent_menu
      @current_menu = Menu.find(params[:menu_id])
      @two_level_menus = current_user.sub_menus(Menu.find(params[:menu_id]).parent_menu)
    else
      @current_menu = current_user.one_level_menus.first
    end
  end

  private
	  def detect_device_type
	    case request.user_agent
      when /iPad/i
        request.variant = :tablet
      when /iPhone/i
        request.variant = :phone
      when /Android/i && /mobile/i
        request.variant = :phone
      when /Android/i
        request.variant = :tablet
      when /Windows Phone/i
        request.variant = :phone
      end
	  end
end