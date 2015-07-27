class CreateBugs < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
      t.string :wid
      t.string :title
      t.string :content

      t.timestamps null: false
    end
    add_index :bugs, :wid
  end
end
