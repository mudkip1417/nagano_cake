class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|

      t.integer  :item_id, null: false
      t.integer  :customer_id, null: false
      t.integer  :amount, null: false
      t.datetime :create_at, null: false,default: -> { 'NOW()' }
      t.datetime :update_at, null: false,default: -> { 'NOW()' }

      t.timestamps
    end
  end
end
