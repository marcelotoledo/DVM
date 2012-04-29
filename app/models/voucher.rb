class Voucher < ActiveRecord::Base
  has_many :statuses
  belongs_to :batch 
end
