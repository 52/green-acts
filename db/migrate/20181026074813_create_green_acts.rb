class CreateGreenActs < ActiveRecord::Migration[5.2]
  def change
    create_table :green_acts do |t|
      t.text :content
      t.text :details
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :green_acts, :created_at, unique: true
  end
end
