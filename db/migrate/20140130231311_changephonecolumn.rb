class Changephonecolumn < ActiveRecord::Migration
  def change
    remove_column :patients, :phone, :integer
    add_column :patients, :phone, :string
  end
end
