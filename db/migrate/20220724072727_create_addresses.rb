class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|

      t.integer  :customer_id, null: false
      t.string   :name, null: false
      t.string   :postal_code, null: false
      t.string   :address, null: false
      t.datetime :create_at, null: false
      t.datetime :update_at, null: false

      t.timestamps
    end
  end
end
