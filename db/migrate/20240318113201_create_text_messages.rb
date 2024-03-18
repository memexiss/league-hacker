class CreateTextMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :text_messages do |t|
      t.integer :owner_id
      t.string :owner_type
      t.string :from, null: false
      t.string :to, null: false
      t.text :body
      t.string :multimedia
      t.string :message_id
      t.integer :status, default: 0
      t.integer :segments, default: 0
      t.decimal :cost, default: 0
      t.datetime :sent_at

      t.timestamps
    end
    add_index :text_messages, [:owner_id, :owner_type]
  end
end
