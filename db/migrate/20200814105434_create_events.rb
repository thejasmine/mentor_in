class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.text :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.text :level
      t.text :link
      t.text :event
      t.integer :capacity
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
