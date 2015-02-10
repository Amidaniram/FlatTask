class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :events, :datetime, :start
  end
end
