class AgenciesController < ApplicationController
  before_action :set_agency, only: [:show, :edit, :update, :destroy]

  def index
    @agencies = Agency.all
  end

  def show
  end

  def new
    @agency = Agency.new
  end

  def edit
  end

  def create
    @agency = Agency.new(agency_params)

    respond_to do |format|
      if @agency.save
        format.html { redirect_to @agency, notice: 'Agency was successfully created.' }
        format.json { render action: 'show', status: :created, location: @agency }
      else
        format.html { render action: 'new' }
        format.json { render json: @agency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agencies/1
  # PATCH/PUT /agencies/1.json
  def update
    respond_to do |format|
      if @agency.update(agency_params)
        format.html { redirect_to @agency, notice: 'Agency was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @agency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agencies/1
  # DELETE /agencies/1.json
  def destroy
    @agency.destroy
    respond_to do |format|
      format.html { redirect_to agencies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agency
      @agency = Agency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agency_params
      params.require(:agency).permit(:name)
    end
end
