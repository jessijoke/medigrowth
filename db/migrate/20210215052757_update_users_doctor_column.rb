class UpdateUsersDoctorColumn < ActiveRecord::Migration
  def change
    remove_column :users, :doctor
    add_column :users, :doctor_id, :integer
  end
end
