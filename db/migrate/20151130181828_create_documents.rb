class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :user, null: false
      t.string :csv_file, null: false
      t.timestamps null: false
    end
  end
end
