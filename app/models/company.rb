# -*- coding: utf-8 -*-

class Company < ActiveRecord::Base
  has_many :users, :dependent => :destroy
  #has_many :vouchers, :through => :batches
  #before_destroy :check_for_childrens

  validates_presence_of :name

  # def check_for_childrens
  #   count = User.where("company_id = ?", self.id).count
  #   if count > 0
  #     logger.debug("Retornando FALSO (#{count})!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
  #     return false
  #   else
  #     logger.debug("Retornando TRUE (#{count})!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
  #     return false
  #   end    
  # end  
end
