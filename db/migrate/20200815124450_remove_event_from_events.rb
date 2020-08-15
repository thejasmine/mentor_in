class RemoveEventFromEvents < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :event, :text
  end
end
