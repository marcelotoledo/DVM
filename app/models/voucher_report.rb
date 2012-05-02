class VoucherReport < ActiveRecord::Base
  belongs_to :gender
  belongs_to :voucher

  validates_presence_of :salesclerk, :total, :gender_id, :age
  validates :total, :numericality => true
  validates :age, :numericality => { :only_integer => true }
end
