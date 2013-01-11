class CombineLocationFieldsOnEvents < ActiveRecord::Migration
  def change
  	change_table :events do |t|
	  t.remove :street, :zip_code
	  t.column :location, :string
  	end
  end
end
