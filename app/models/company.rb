# -*- coding: utf-8 -*-

class Company < ActiveRecord::Base
  has_many :users
  has_many :vouchers, :through => :batches
  
  validates_presence_of :name
end
