class VoucherController < ApplicationController
  #before_filter :logged_in?
  
  def index
  end

  def searchold
    if params[:search_query] && params[:search_query].length == 8
      voucher = Voucher.where("voucher = ? AND status_id = 1", params[:search_query]).exists?
      
      if voucher
        @voucher_report = VoucherReport.new
        @voucher = Voucher.joins(:batch).where("vouchers.voucher = ?", params[:search_query]).limit(1)
        render 'show'
        return
      else
        @voucher_found = false
      end
    else
      @voucher_found = false
    end

    if !@voucher_found
      redirect_to vouchers_path, alert: 'Voucher Not Found'
    end
  end

  def search
    voucher = Voucher.where("voucher = ? AND status_id = 1", params[:search_query]).exists?
    
    if voucher
      show
      #format.html { render :action => '/show' and return }
    else
      redirect_to vouchers_path, alert: 'Voucher Not Found'
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
        format.html { redirect_to vouchers_path, alert: 'Voucher Not Found to Show' }
      end
    end
  end  
end
