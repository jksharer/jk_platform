class StepsController < ApplicationController
  before_action :set_step, only: [ :show, :edit, :update, :destroy ]

  def index
    @steps = Step.all
  end

  def show
  end

  def new
    @step = Step.new
    if params[:procedure_id].nil?
      redirect_to procedures_url
      return
    end
    @procedure = Procedure.find(params[:procedure_id])
  end

  def edit
    @procedure = @step.procedure
  end

  def create
    check_user_exists
    @step = Step.new(step_params)
    @procedure = Procedure.find(params[:procedure_id]) #在保存失败render 'new'时起作用，使其不出错
    @step.procedure = @procedure
    respond_to do |format|
      if @step.save
        format.html { redirect_to @step.procedure, 
          notice: 'Step was successfully created.' }
        format.json { render action: 'show', status: :created, location: @step }
      else
        format.html { render action: 'new' }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    check_user_exists
    respond_to do |format|
      if @step.update(step_params)
        format.html { redirect_to @step.procedure, 
          notice: 'Step was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @step.destroy
    respond_to do |format|
      format.html { redirect_to @step.procedure }
      format.json { head :no_content }
    end
  end

  def check_user_exists
    unless User.find(params[:step][:user_id])
      flash[:notice] = "the user does't exists."
      redirect_to new_step_path(procedure: @procedure)
      return  
    end
  end

  private
    def set_step
      @step = Step.find(params[:id])
    end

    def step_params
      params.require(:step).permit(:view_order, :user_id, :procedure_id)
      # ps = params.require(:step).permit(:view_order, :user_id, :procedure_id)
      # ps[:user] = User.find_by(username: ps[:user])
      # ps[:procedure] = Procedure.find(params[:procedure])
      # return ps
    end
end