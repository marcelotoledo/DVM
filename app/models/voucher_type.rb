class VoucherType < ActiveRecord::Base
  has_many :batches
end
