class CreateRepeatTypes < ActiveRecord::Migration
  def change
    create_table :repeat_types do |t|

      t.timestamps null: false
    end
  end
end
