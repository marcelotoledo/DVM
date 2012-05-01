class VoucherReport < ActiveRecord::Base
  has_one :gender
  belongs_to :vouchers

  validates_presence_of :salesclerk, :total, :gender_id, :age
  validates :total, :numericality => true
  validates :age, :numericality => { :only_integer => true }
end
