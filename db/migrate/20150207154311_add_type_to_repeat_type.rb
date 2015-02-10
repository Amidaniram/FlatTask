class AddTypeToRepeatType < ActiveRecord::Migration
  def change
    add_column :repeat_types, :type, :string
  end
end
