class AddScraperToLinks < ActiveRecord::Migration[7.2]
  def change
    add_column :links, :scraper, :string
  end
end
