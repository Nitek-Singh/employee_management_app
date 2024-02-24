# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

employees_data = [
  {
    first_name: "John",
    last_name: "Doe",
    email: "john@example.com",
    date_of_joining: Date.new(2023, 6, 1),
    salary: 20000,
    phone_numbers_attributes: [{ number: "1234567890" }]
  },
  {
    first_name: "Jane",
    last_name: "Smith",
    email: "jane@example.com",
    date_of_joining: Date.new(2022, 8, 15),
    salary: 25000,
    phone_numbers_attributes: [{ number: "9876543210" }]
  },
]

# Create employee records
employees_data.each do |employee_data|
  Employee.create!(employee_data)
end
