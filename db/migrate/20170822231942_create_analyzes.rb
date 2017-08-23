class CreateAnalyzes < ActiveRecord::Migration[5.0]
  def change
    create_table :analyzes do |t|
      t.integer :number_id
      t.string :domain, :title
      t.text :description, :keyword, :remarks
      t.timestamps
    end
  end
end
