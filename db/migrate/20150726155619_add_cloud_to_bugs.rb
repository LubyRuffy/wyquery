class AddCloudToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :iscloud, :boolean, :comment => "乌云图标"
    add_column :bugs, :ismoney, :boolean, :comment => "金钱图标"
  end
end
