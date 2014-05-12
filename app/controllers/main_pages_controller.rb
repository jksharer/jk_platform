class MainPagesController < ApplicationController
  include ApplicationHelper
  before_action :authorize, only: [ :home, :about ]  

  def home
    #取出所有已审批发布的公告
    @announcements = Announcement.where(workflow_state: "accepted").order('created_at DESC').
        page(params[:page]).per_page(8)
    #待审批公告
    @being_reviews = needed_my_review("Announcement").paginate(page: params[:page], per_page: 5)
    #项目信息
    @projects = Project.all.order("status asc")
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