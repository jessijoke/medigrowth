class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :password_digest
      t.integer :is_a_doctor
    end
  end
end
