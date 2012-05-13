class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.boolean :deleted, :default => false

      t.timestamps
    end
  end
end
