class AddIsADoctorColumn < ActiveRecord::Migration
  def change
    add_column :users, :is_a_doctor, :integer
    add_column :doctors, :is_a_doctor, :integer
  end
end
