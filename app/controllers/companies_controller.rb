class CompaniesController < ApplicationController
  before_filter :logged_in?
  before_filter :has_permission_to_be_here?  
  
  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.where("deleted = FALSE").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to companies_path, notice: 'Empresa criada com sucesso.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to companies_path, notice: 'Empresa atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company = Company.find(params[:id])

    # @company.destroy
    # respond_to do |format|
    #   format.html { redirect_to companies_url }
    #   format.json { head :no_content }
    # end

    @company.deleted = true    
    respond_to do |format|
      if @company.save
        format.html { redirect_to companies_path, notice: 'Empresa removida com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "index" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end
end
