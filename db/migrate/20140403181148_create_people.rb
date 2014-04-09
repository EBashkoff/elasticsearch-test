class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :l_name
      t.string :f_name
      t.string :email
      t.string :city
      t.string :state
      t.string :zip
      t.integer :age

      t.timestamps
    end
  end
end
