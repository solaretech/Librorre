class AddDefaultCheckedToMessage < ActiveRecord::Migration[5.2]
  def change
    change_column :messages, :checked, :boolean, default: false
  end
end
