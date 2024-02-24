class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]

  # GET /employees
  def index
    @employees = Employee.all
    render json: @employees
  end

  # GET /employees/:id
  def show
    render json: @employee
  end

  # POST /employees
  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      render json: { message: 'Employee created successfully', employee: @employee }, status: :created
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /employees/:id
  def update
    if @employee.update(employee_params)
      render json: { message: 'Employee updated successfully', employee: @employee }
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /employees/:id
  def destroy
    @employee.destroy
    render json: { message: 'Employee deleted successfully' }
  end

  def tax_deductions
    @employees = Employee.all
    tax_deductions = @employees.map { |employee| calculate_tax_deduction(employee) }
    render json: tax_deductions
  end

  private

  def calculate_tax_deduction(employee)
    yearly_salary = calculate_yearly_salary(employee)
    tax_amount = calculate_tax_amount(yearly_salary)
    cess_amount = calculate_cess_amount(yearly_salary)

    {
      employee_code: employee.id,
      first_name: employee.first_name,
      last_name: employee.last_name,
      yearly_salary: yearly_salary,
      tax_amount: tax_amount,
      cess_amount: cess_amount
    }
  end

  def calculate_yearly_salary(employee)
    current_date = Date.today
    doj = employee.date_of_joining

    # Calculate the start date and end date of the financial year cycle
    start_date = [doj, Date.new(doj.year, 4, 1)].max  # Start counting from April or the joining month, whichever is later
    end_date = [current_date, Date.new(current_date.year, 3, 31)].min  # End counting in March of the current financial year

    # Calculate the number of months worked within the financial year cycle
    months_worked = (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month) + 1

  # Calculate the yearly salary based on the number of months worked
    yearly_salary = employee.salary * months_worked

    return yearly_salary
  end

  def calculate_tax_amount(yearly_salary)
    case yearly_salary
    when 0..250000
      0
    when 250001..500000
      (yearly_salary - 250000) * 0.05
    when 500001..1000000
      12500 + (yearly_salary - 500000) * 0.1
    else
      37500 + (yearly_salary - 1000000) * 0.2
    end
  end

  def calculate_cess_amount(yearly_salary)
    cess_threshold = 2500000
    if yearly_salary > cess_threshold
      cess_amount = (yearly_salary * 0.02)
    else
      cess_amount = 0
    end
    return cess_amount
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Employee not found' }, status: :not_found
  end

  # Only allow a trusted parameter "white list" through.
  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :date_of_joining, :salary, phone_numbers_attributes: [:number])
  end
end
