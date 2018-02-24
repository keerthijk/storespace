class CreateSpaces < ActiveRecord::Migration[5.0]
  def change
    create_table :spaces do |t|
      t.string :title
      t.integer :size
      t.decimal :price_per_day
      t.decimal :price_per_week
      t.decimal :price_per_month
      t.references :store
      t.timestamps
    end
  end
end
