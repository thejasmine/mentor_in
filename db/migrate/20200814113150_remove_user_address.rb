class RemoveUserAddress < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :address
  end
end
