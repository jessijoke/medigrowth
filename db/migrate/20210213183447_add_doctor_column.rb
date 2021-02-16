class AddDoctorColumn < ActiveRecord::Migration
  def change
    add_column :users, :is_doctor, :boolean
  end
end
