class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.string :title
      t.string :city
      t.text :street
      t.integer :spaces_count
      t.timestamps
    end
  end
end
