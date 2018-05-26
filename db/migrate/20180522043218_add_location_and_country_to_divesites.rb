class AddLocationAndCountryToDivesites < ActiveRecord::Migration[5.2]
  def change
    add_column :divesites, :location, :string
    add_column :divesites, :country, :string
  end
end
