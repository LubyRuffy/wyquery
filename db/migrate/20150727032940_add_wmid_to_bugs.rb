class AddWmidToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :wmid, :integer, :comment => "wuyoo的真实id, wooyun-2015-0119852对应119852"
  end
end
