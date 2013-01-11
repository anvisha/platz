class AddWhoToEvents < ActiveRecord::Migration
  def change
    add_column :events, :who, :string
  end
end
