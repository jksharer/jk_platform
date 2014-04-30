class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  def index
    @departments = Department.order('name asc')
  end

  def show
  end

  def new
    @department = Department.new
  end

  def edit
  end

  def create
    @department = Department.new(department_params)
    @department.agency = current_user.agency
    # @department.parent_department = department_params[:parent_department]
    
    respond_to do |format|
      if @department.save
        format.html { redirect_to departments_url, 
          notice: 'Department was successfully created. ' }
        format.json { render action: 'show', 
          status: :created, location: @department }
      else
        format.html { render action: 'new' }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to departments_url, 
          notice: 'Department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    unless @department.sub_departments.empty?
      redirect_to departments_url, 
        notice: "The department has sub departments, you just can't delete it."
      return
    end
    @department.destroy
    respond_to do |format|
      format.html { redirect_to departments_url }
      format.json { head :no_content }
    end
  end

  private
    def set_department
      @department = Department.find(params[:id])
    end

    # 获取前端参数的正确方式是: params[:department][:parent_department]，
    # 因为前端使用了form_for以及f.select这种标签
    def department_params
      ps = params.require(:department).permit(:name, :description, :parent_department)
      ps[:parent_department] = Department.find_by(name: params[:department][:parent_department], 
        agency_id: current_user.agency.id)
      return ps
    end
end