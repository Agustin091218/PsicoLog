class AddEmailAndPhoneToPatients < ActiveRecord::Migration[7.2]
  def change
    add_column :patients, :email, :string
    add_column :patients, :phone, :string
  end
end
