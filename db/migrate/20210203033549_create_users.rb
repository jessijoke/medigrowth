class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :password_digest
      t.integer :is_a_doctor
      t.integer :doctor_id
    end
  end
end

