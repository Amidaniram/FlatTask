class RemoveTypeFromRepeatType < ActiveRecord::Migration
  def change
    remove_column :repeat_types, :type, :string
  end
end
