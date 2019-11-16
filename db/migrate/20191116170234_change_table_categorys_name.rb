class ChangeTableCategorysName < ActiveRecord::Migration[5.2]
  def change
    rename_table :categorys, :categories
  end
end
