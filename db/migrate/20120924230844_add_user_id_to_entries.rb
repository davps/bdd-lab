class AddUserIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :user, :reference
  end
end
