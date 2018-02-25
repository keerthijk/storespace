class CreateSpaces < ActiveRecord::Migration[5.0]
  def change
    execute 'CREATE SEQUENCE display_id_seq START 1;'
    create_table :spaces, id: :uuid do |t|
      t.string :title
      t.integer :size
      t.decimal :price_per_day
      t.decimal :price_per_week
      t.decimal :price_per_month
      t.uuid :store_id
      t.integer :display_id
      t.timestamps
    end
    execute "ALTER TABLE spaces ALTER COLUMN display_id SET DEFAULT NEXTVAL('display_id_seq');"
  end
end
