class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.string :voucher
      t.integer :status_id
      t.integer :batch_id

      t.timestamps
    end
  end
end
