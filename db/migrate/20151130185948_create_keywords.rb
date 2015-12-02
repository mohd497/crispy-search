class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :text, null: false
      t.text :html_source, limit: 4294967295
      t.string :total_result
      t.timestamps null: false
    end

    add_index :keywords, :text, unique: true
  end
end
