# -*- coding: utf-8 -*-

class Company < ActiveRecord::Base
  has_many :users, :dependent => :destroy
  #has_many :vouchers, :through => :batches
  
  validates_presence_of :name
end
