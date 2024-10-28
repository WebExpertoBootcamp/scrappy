class CreateUserCategories < ActiveRecord::Migration[7.2]
  def change
    create_join_table :users, :categories
  end
end
