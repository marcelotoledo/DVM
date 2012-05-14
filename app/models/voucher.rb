class Voucher < ActiveRecord::Base
  has_one :voucher_report, :dependent => :destroy
  belongs_to :batch
  belongs_to :status
end
