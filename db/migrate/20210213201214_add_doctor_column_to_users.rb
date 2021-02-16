class AddDoctorColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :doctor, :string
  end
end
