class CreateSearchResults < ActiveRecord::Migration
  def change
    create_table :search_results do |t|
      t.references :keyword, null: false
      t.string :type, default: 'NonAdword'
      t.string :title, null: false
      t.string :url, null: false
      t.integer :position, limit: 1
      t.timestamps null: false
    end

    add_column :keywords, :adwords_count, :integer, default: 0, after: :html_source
    add_column :keywords, :non_adwords_count, :integer, default: 0, after: :html_source

    add_index :search_results, :type
    add_index :search_results, :position
  end
end
