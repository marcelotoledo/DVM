class VoucherController < ApplicationController
  def index
  end

  def search
    if params[:search_query] && params[:search_query].length == 8
      voucher = Voucher.where("voucher_id = ? and status_id = 1", params[:search_query])
      
      if voucher
        @voucher_found = true
      else
        @voucher_found = false
      end
    else
      @voucher_found = false
    end
      
     render 'index'
  end  

  def consume
    @voucher = Voucher.find_by_voucher(params[:voucher])
    @voucher.update_attributes(:status_id => 2)
    @consumed = true
    
    render 'index', :consumed => true
  end
end
