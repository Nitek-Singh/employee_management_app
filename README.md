# README

# EmployeesManagementApp

This app is responsible for managing employees and calculating tax deductions in the Employee Management application.

## Actions

### Index

- **Endpoint:** `GET /employees`
- **Description:** Retrieves all employees.
- **Response:** Returns a JSON array containing the details of all employees.

### Show

- **Endpoint:** `GET /employees/:id`
- **Description:** Retrieves details of a specific employee.
- **Response:** Returns a JSON object containing the details of the employee with the specified ID.

### Create

- **Endpoint:** `POST /employees`
- **Description:** Creates a new employee.
- **Parameters:** Expects JSON data containing employee details.
- **Response:** Returns a JSON object with a success message if the employee is created successfully, or error messages if there are validation errors.

### Update

- **Endpoint:** `PATCH/PUT /employees/:id`
- **Description:** Updates details of an existing employee.
- **Parameters:** Expects JSON data containing updated employee details.
- **Response:** Returns a JSON object with a success message if the employee is updated successfully, or error messages if there are validation errors.

### Destroy

- **Endpoint:** `DELETE /employees/:id`
- **Description:** Deletes an employee.
- **Response:** Returns a JSON object with a success message if the employee is deleted successfully.

### Tax Deductions

- **Endpoint:** `GET /employees/:id/tax_deductions`
- **Description:** Calculates tax deductions for all employees.
- **Response:** Returns a JSON array containing tax deduction details for each employee.

## Private Methods

- `calculate_tax_deduction(employee)`: Calculates tax deduction details for a given employee.
- `calculate_yearly_salary(employee)`: Calculates the yearly salary of an employee considering the date of joining.
- `calculate_tax_amount(yearly_salary)`: Calculates the tax amount based on the yearly salary.
- `calculate_cess_amount(yearly_salary)`: Calculates the cess amount based on the yearly salary.

## Callbacks

- `set_employee`: Sets the `@employee` instance variable before executing actions requiring a specific employee.
- `employee_params`: Defines permitted parameters for employee creation and update.


