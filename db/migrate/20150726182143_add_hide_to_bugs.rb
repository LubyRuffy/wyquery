class AddHideToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :ishide, :boolean, :comment => "是否被隐藏掉了"
  end
end
