# -*- coding: utf-8 -*-

class UsersController < ApplicationController
  before_filter :logged_in?
  before_filter :has_permission_to_be_here?

  def upload_index
    @errors = []
    @success = []
    render 'upload'
  end  
  
  def upload
    require 'csv'
    
    csv_text = File.read(params[:upload][:csv].tempfile)
    csv = CSV.parse(csv_text, :col_sep => ';')
    @errors = []
    @success = []
    csv.each do |row|
      company = Company.find_or_create_by_name(row[3])
      new_user = User.new(:name => row[0], :email => row[1], :password => row[2], :company_id => company.id)
      if !new_user.save
        @errors << new_user.dup
      else
        @success << row[1]
      end
    end
  end
  
  def index
    if params[:filter]
      @users = User.where("deleted = FALSE and company_id = ?", params[:filter][:company_id])
    else
      @users = User.where("deleted = FALSE")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'Usuário foi criado com sucesso.' }
        format.json { render json: users_url, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_url, notice: 'Usuário foi atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.deleted = true

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'Usuário removido com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "index" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
