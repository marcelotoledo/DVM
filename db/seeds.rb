# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Status.create([{ description: 'Novo' }, { description: 'Usado' }])
VoucherType.create([{ description: 'Free' }, { description: 'Paid' }, { description: 'Free + Paid' }])
Gender.create([{ description: 'Masculino' }, { description: 'Feminino' }])
Company.create([{ name: 'DropGifts' }])
User.create(:name => 'root - delete me' , :email => 'root@root.com', :password => 'rootroot', :password_confirmation => 'rootroot', :company_id => 1)
