class CreateDiveDivesites < ActiveRecord::Migration[5.2]
  def change
    create_table :dive_divesites do |t|
      t.integer :dive_id
      t.integer :divesite_id
    end
  end
end
