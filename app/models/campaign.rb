class Campaign < ActiveRecord::Base
  has_many :batches
  belongs_to :company

  validates_presence_of :name, :company_id
end
