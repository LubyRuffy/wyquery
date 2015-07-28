class AddRankToBug < ActiveRecord::Migration
  def change
    add_column :bugs, :rank, :integer
    add_index :bugs, :wmid
  end
end
