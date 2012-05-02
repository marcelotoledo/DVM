class Batch < ActiveRecord::Base
  has_many :vouchers, :dependent => :destroy
  has_many :voucher_reports, :through => :vouchers
  belongs_to :voucher_type
  belongs_to :company
  
  accepts_nested_attributes_for :vouchers
  
  validates_presence_of :name, :company_id, :quantity, :value, :voucher_type_id, :expiration
  validates :quantity, :numericality => { :only_integer => true }
  validates :value, :numericality => true
end
