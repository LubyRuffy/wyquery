class AddCorpToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :corporation, :string, :comment => "企业"
    add_column :bugs, :author, :string, :comment => "白帽子"
  end
end
