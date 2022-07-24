class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|

      t.integer :order_id, null: false
      t.integer :item_id, null: false
      t.integer :price, null: false
      t.integer :amount, null: false
      t.integer :maiking_status, null: false, default: 0
      t.datetime :create_at, null: false
      t.datetime :update_at, null: false


      t.timestamps
    end
  end
end
