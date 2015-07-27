class AddCreateTimeToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :created_time, :datetime
    add_column :bugs, :published_time, :datetime
  end
end
