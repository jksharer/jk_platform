class AgenciesController < ApplicationController
  before_action :set_agency, only: [:show, :edit, :update, :destroy]

  def index
    @agencies = Agency.order('name asc').page(params[:page]).per_page(5)
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
        format.html { redirect_to agencies_path, 
          notice: 'Agency was successfully created.' }
        format.json { render action: 'show', 
          status: :created, location: @agency }
      else
        format.html { render action: 'new' }
        format.json { render json: @agency.errors, 
          status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agencies/1
  # PATCH/PUT /agencies/1.json
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
    # if @agency.users.size > 0 
    #   redirect_to agencies_url, 
    #     notice: "The Agency has some users associated, you can't destroy it."
    # end
    # @agency.lower_agencies.each do |agency|
    #   agency.higher_agency = nil
    # end
    # @agency.destroy
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
      ps = params.require(:agency).permit(:name, :description, :higher_agency)
      ps[:higher_agency] = Agency.find_by(name: ps[:higher_agency])
      return ps
    end
end
