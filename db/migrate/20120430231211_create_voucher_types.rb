class CreateVoucherTypes < ActiveRecord::Migration
  def change
    create_table :voucher_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
