class CreateDives < ActiveRecord::Migration[5.2]
  def change
    create_table :dives do |t|
      t.string :date
      t.integer :divesite_id
      t.integer :user_id
      t.string :notes
    end
  end
end
