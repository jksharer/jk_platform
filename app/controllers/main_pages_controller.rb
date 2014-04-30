class MainPagesController < ApplicationController
  before_action :authorize, only: [ :home, :about ]  

  def home
  	@roles = Role.all
  	@users = User.all
  	@departments = Department.order('name asc')
  end

  def about
  end

  def my
  	@current_user = current_user
  end

  def change_passwoesrd
  	@current_user = current_user
  end

  def update_password
  	password = params[:password]
  	password_confirmation = params[:password_confirmation]			
  	if password.nil? || password.length < 6
  		flash[:notice] = "the length of password must be greater than 6."
  		redirect_to change_password_path
  		return
  	elsif password != password_confirmation
  		flash[:notice] = "the password does not equal confirmation."
  		redirect_to change_password_path
  		return
  	end
  	user = current_user
  	user.password = password
  	user.password_confirmation = password_confirmation
  	user.save!
  	flash[:notice] = "the password has successfully updated."
  	redirect_to my_path		
  end
end