class AddField1ToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :field1, :string
  end
end
