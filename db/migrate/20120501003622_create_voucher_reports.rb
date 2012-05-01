class CreateVoucherReports < ActiveRecord::Migration
  def change
    create_table :voucher_reports do |t|
      t.integer :voucher_id
      t.string :salesclerk
      t.integer :gender_id
      t.integer :age
      t.decimal :total, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
