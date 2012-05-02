# -*- coding: utf-8 -*-
class VoucherController < ApplicationController
  before_filter :logged_in?
  
  def index
  end

  def search
    voucher = Voucher.joins(:batch).where("vouchers.voucher = ? AND vouchers.status_id = 1 AND batches.expiration > ? AND batches.company_id = ?", params[:search_query], Time.now, User.find(session[:user_id]).company_id).exists?
    
    if voucher
      show
      #format.html { render :action => '/show' and return }
    else
      redirect_to vouchers_path, alert: 'Voucher não encontrado'
    end
  end
  
  def save_report
    @voucher = Voucher.find_by_id(params[:voucher_report][:voucher_id])
    @voucher.status_id = 2    

    @voucher_report_submitted = VoucherReport.new(params[:voucher_report])
    
    if @voucher_report_submitted.save && @voucher.save
      respond_to do |format|
        format.html { redirect_to vouchers_url, notice: 'Voucher marcado como utilizado' }
        format.json { render json: vouchers_url, status: :created, location: vouchers_url }
      end      
    else
      show(@voucher_report_submitted)
    end
  end
  
  def show(voucher_report_submitted = nil)
    @voucher_report = voucher_report_submitted ? voucher_report_submitted : VoucherReport.new
    @voucher = Voucher.joins(:batch).where("vouchers.voucher = ?", params[:search_query])
    @voucher_report_submitted = voucher_report_submitted
    
    respond_to do |format|
      if @voucher
        format.html { render 'show' }
      else
        format.html { redirect_to vouchers_path, alert: 'Voucher não encontrado' }
      end
    end
  end  
end
