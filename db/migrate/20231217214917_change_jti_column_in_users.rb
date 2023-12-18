class ChangeJtiColumnInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :jti, :string, null: false
    add_index :users, :jti, unique: true, name: 'index_users_on_jti_unique'
  end
end

