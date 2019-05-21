class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: {unique: true}
      t.string :password, null: false
      t.integer :role, null: false, default: 0, limit: 1
      t.string :auth_token

      t.timestamps
    end
  end
end
