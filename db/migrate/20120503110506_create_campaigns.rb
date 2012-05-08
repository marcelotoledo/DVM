class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.integer :company_id
      t.string :name
      t.boolean :is_active

      t.timestamps
    end
  end
end
