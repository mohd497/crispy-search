class AddMissingFieldToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :total_links_count, :string, after: :html_source
  end
end
