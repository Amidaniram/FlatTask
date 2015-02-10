class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.date :datetime
      t.integer :repeat_time_id

      t.timestamps null: false
    end
  end
end
