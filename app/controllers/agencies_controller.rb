class AgenciesController < ApplicationController
  before_action :set_agency, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  def index
    @agencies = Agency.order('name asc').page(params[:page]).per_page(5)
  end

  def show
    render layout: 'empty'
  end

  def new
    @agency = Agency.new
    render layout: 'empty'
  end

  def edit
    render layout: 'empty'
  end

  def create
    @agency = Agency.new(agency_params)

    respond_to do |format|
      if @agency.save
        format.html { redirect_to agencies_path, 
          notice: 'Agency was successfully created.' }
        format.json { render action: 'show', 
          status: :created, location: @agency }
      else
        format.html { render action: 'new', layout: 'empty' }
        format.json { render json: @agency.errors, 
          status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @agency.update(agency_params)
        format.html { redirect_to agencies_path, 
          notice: 'Agency was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @agency.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # 不允许删除机构
    respond_to do |format|
      format.html { redirect_to agencies_url, 
        notice: "The rule is anyone CAN'T destroy Agency." }
      format.json { head :no_content }
    end
  end

  private
    def set_agency
      @agency = Agency.find(params[:id])
    end

    def agency_params
      params.require(:agency).permit(:name, :description)
    end
end
