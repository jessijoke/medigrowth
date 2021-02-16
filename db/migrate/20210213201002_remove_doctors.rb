class RemoveDoctors < ActiveRecord::Migration
  def change
    remove_column :users, :is_doctor, :boolean
  end
end
