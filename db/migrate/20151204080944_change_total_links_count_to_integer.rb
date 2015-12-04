class ChangeTotalLinksCountToInteger < ActiveRecord::Migration
  def change
    change_column :keywords, :total_links_count, :integer
  end
end
