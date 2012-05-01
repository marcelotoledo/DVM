class BatchesController < ApplicationController
  #before_filter :logged_in?  
  require 'voucher'
  
  # GET /batches
  # GET /batches.json
  def index
    @batches = Batch.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @batches }
    end
  end

  def download
    require 'csv'

    csv_string = CSV.generate do |csv|
      csv << [ 'voucher', 'pin', 'value', 'type', 'expiration' ]
      csv << [ '', '', '', '', '' ]      
      
      vouchers = Voucher.where("batch_id = ?", params[:id])
      vouchers.each do |v|
        csv << [ v.voucher, '', v.batch.value, v.batch.voucher_type.description, v.batch.expiration ]
      end
    end

    send_data csv_string,
    :type => 'text/csv; charset=iso-8859-1; header=present',
    :disposition => "attachment; filename=batch-#{Time.now.strftime('%d-%m-%y--%H-%M')}.csv"
  end

  def reports
    @voucher_reports = VoucherReport.all
  end  

  # GET /batches/1
  # GET /batches/1.json
  def show
    @batch = Batch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @batch }
    end
  end

  # GET /batches/new
  # GET /batches/new.json
  def new
    @batch = Batch.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @batch }
    end
  end

  # POST /batches
  # POST /batches.json
  def create
    @batch = Batch.new(params[:batch])
    n = DVM::NewBase.new(defined?(Voucher.last.voucher) ? Voucher.last.voucher : nil)
    1.upto(params[:batch][:quantity].to_i) do |number|
      n.next
      @batch.vouchers_attributes = [ { :voucher => n.value.dup, :status_id => 1 } ]
    end

    respond_to do |format|
      if @batch.save
        format.html { redirect_to @batch, notice: 'Batch was successfully created.' }
        format.json { render json: @batch, status: :created, location: @batch }
      else
        format.html { render action: "new" }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /batches/1
  # DELETE /batches/1.json
  def destroy
    @batch = Batch.find(params[:id])
    @batch.destroy

    respond_to do |format|
      format.html { redirect_to batches_url }
      format.json { head :no_content }
    end
  end
end
