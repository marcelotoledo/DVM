class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.string :name
      t.integer :company_id
      t.integer :quantity
      t.decimal :value, :precision => 8, :scale => 2
      t.integer :voucher_type_id
      t.datetime :expiration

      t.timestamps
    end
  end
end
