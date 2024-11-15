class AddColumnToLink < ActiveRecord::Migration[7.2]
  def change
    add_column :links, :isActive, :boolean
  end
end
