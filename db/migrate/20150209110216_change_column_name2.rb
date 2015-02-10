class ChangeColumnName2 < ActiveRecord::Migration
  def change
    rename_column :events, :repeat_time_id, :repeat_type_id
  end
end
