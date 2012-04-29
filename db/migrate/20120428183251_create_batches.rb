class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.string :name
      t.integer :company_id
      t.integer :quantity

      t.timestamps
    end
  end
end
