class AnnouncementsController < ApplicationController
  include ApplicationHelper
  require 'will_paginate/array'

  before_action :set_announcement, only: [ :show, :edit, :update, :destroy, 
    :handle_workflow, :handle_review ]

  def index
    # 如果没有查询条件和参数，则返回所有已审批发布公告
    if params[:conditions].nil?
      @announcements = Announcement.where(workflow_state: "accepted").order('created_at DESC').
        page(params[:page]).per_page(10)
      @scope = "all"
    else
      conditions = ""
      params[:conditions].each { |key, value| conditions << "#{key} = #{value}" }
      @announcements = Announcement.where(conditions).order('created_at DESC').
        page(params[:page]).per_page(10)
      @scope = "mine"
    end
    respond_to do |format|
      format.js 
      format.json
      format.html          
      format.html.phone    
      format.html.tablet   
    end  
  end

  #待审批通知公告
  def being_reviewed
    @announcements = needed_my_review("Announcement").paginate(page: params[:page], per_page: 10)
    # @announcements = WillPaginate::Collection.create(params[:page], 10, @announcements.length) do |pager|
    #   pager.replace @announcements
    # end
    @scope = "being_reviewed"
    render 'index'
  end

  def show
    @reviews = Review.where(model_type: "Announcement", object: @announcement).
      sort { |a, b| a.step.view_order <=> b.step.view_order }
  end

  def new
    @announcement = Announcement.new
    render layout: 'empty'
  end

  def edit
  end

  def create
    @announcement = Announcement.new(announcement_params)
    @announcement.user = current_user
    puts params[:commit]
    respond_to do |format|
      if @announcement.save
        # if params[:commit] == "save_and_submit"
        if params[:save_and_submit]
          redirect_to handle_workflow_path(id: @announcement.id, event: "submit!")
          return
        end
        format.html { redirect_to @announcement, 
          notice: 'Announcement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @announcement }
      else
        format.html { render action: 'new' }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to @announcement, notice: 'Announcement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url }
      format.json { head :no_content }
    end
  end

  def handle_workflow
    method = @announcement.method(params[:event].to_sym)
    method.call
    respond_to do |format|
      format.html { redirect_to @announcement, 
        notice: "#{method.name}  has called." }
      format.json { head :no_content }
    end
  end

  def handle_review
    review = Review.find(params[:review])
    review.state = params[:judge]
    review.save
    if  review.state == "rejected"
      redirect_to handle_workflow_path(id: @announcement.id, event: "reject!")
      return
    end
    states = Review.where(model_type: "Announcement", object: @announcement).pluck(:state)
    if states.count("accepted") == states.size
      redirect_to handle_workflow_path(id: @announcement.id, event: "accept!")
      return
    end
    #如果没有拒绝，而且审批没有结束，则设置下一个审批状态为当前审批
    set_next_review_to_current(@announcement)
    redirect_to @announcement
  end

  private
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    def announcement_params
      params.require(:announcement).permit(:name, :announcement_type, :content, :procedure_id)
    end
end