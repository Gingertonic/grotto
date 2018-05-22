class CreateDivesites < ActiveRecord::Migration[5.2]
  def change
    create_table :divesites do |t|
      t.string :name
    end
  end
end
