class Batch < ActiveRecord::Base
  has_many :vouchers, :dependent => :destroy
  belongs_to :company
  
  accepts_nested_attributes_for :vouchers
  
  validates_presence_of :name, :company_id, :quantity
end
