class ExpensesController < ApplicationController
  before_action :set_property
  before_action :set_expense, only: %i[ show update destroy ]

  def index
    @expenses = @property.expenses

    render json: @expenses
  end

  def show
    render json: @expense
  end

  def create
    @expense = @property.expenses.build(expense_params)

    if @expense.save
      render json: @expense, status: :created, location: property_expense_url(@property, @expense)
    else
      render json: @expense.errors, status: :unprocessable_entity
    end
  end

  def update
    if @expense.update(expense_params)
      render json: @expense
    else
      render json: @expense.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy
  end

  private

  def set_expense
    @expense = @property.expenses.find(params[:id])
  end

  def set_property
    @property = Property.find(params[:property_id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :type)
  end
end
