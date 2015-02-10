class AddTitleToRepeatType < ActiveRecord::Migration
  def change
    add_column :repeat_types, :title, :string
  end
end
