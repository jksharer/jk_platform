class ProceduresController < ApplicationController
  before_action :set_procedure, only: [:show, :edit, :update, :destroy]

  def index
    @procedures = Procedure.all
  end

  def show
  end

  def new
    @procedure = Procedure.new
    render layout: 'empty'
  end

  def edit
    render layout: 'empty'
  end

  def create
    @procedure = Procedure.new(procedure_params)

    respond_to do |format|
      if @procedure.save
        format.html { redirect_to @procedure, 
          notice: 'Procedure was successfully created.' }
        format.json { render action: 'show', status: :created, location: @procedure }
      else
        format.html { render action: 'new' }
        format.json { render json: @procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @procedure.update(procedure_params)
        format.html { redirect_to @procedure, notice: 'Procedure was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @procedure.destroy
    respond_to do |format|
      format.html { redirect_to procedures_url }
      format.json { head :no_content }
    end
  end

  private
    def set_procedure
      @procedure = Procedure.find(params[:id])
    end

    def procedure_params
      params.require(:procedure).permit(:name)
    end
end
