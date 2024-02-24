class CreateEmployeeAndPhoneNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :first_name, null: false, limit: 100
      t.string :last_name, null: false, limit: 100
      t.string :email, null: false, limit: 100
      t.datetime :date_of_joining, null: false
      t.integer :salary, null: false

      t.timestamps
    end

    create_table :phone_numbers do |t|
      t.string :number
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
