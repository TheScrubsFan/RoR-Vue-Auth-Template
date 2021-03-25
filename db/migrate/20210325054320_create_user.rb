class CreateUser < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :encrypted_password, null: false

      t.boolean :is_deleted, null: false, default: false

      t.timestamps

      t.index [:email, :is_deleted], unique: true
    end
  end
end
