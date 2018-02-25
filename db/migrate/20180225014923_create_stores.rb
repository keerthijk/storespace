class CreateStores < ActiveRecord::Migration[5.0]
  def change
    execute 'CREATE SEQUENCE display_store_id_seq START 1;'
    create_table :stores, id: :uuid do |t|
      t.string :title
      t.string :city
      t.text :street
      t.integer :spaces_count
      t.integer :display_store_id
      t.timestamps
    end
    execute "ALTER TABLE stores ALTER COLUMN display_store_id SET DEFAULT NEXTVAL('display_store_id_seq');"
  end
end
