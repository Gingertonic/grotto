class AddTimeAndLengthToDives < ActiveRecord::Migration[5.2]
  def change
    add_column :dives, :time, :string
    add_column :dives, :length, :integer
  end
end
