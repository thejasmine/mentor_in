class AddColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :content, :string
    add_column :users, :user_type, :string
    add_column :users, :description, :string
    add_column :users, :expertise, :string
    add_column :users, :about_me, :string
  end
end
