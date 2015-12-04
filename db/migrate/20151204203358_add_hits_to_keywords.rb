class AddHitsToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :hits, :integer, default: 1, after: :total_result
  end
end
