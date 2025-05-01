class RenameViewCountInLinks < ActiveRecord::Migration[7.1]
  def change
    rename_column :links, :view_count, :views_count
  end
end
