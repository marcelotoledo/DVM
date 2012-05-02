class Voucher < ActiveRecord::Base
  has_one :voucher_report
  belongs_to :batch
  belongs_to :status
end
