class IncomesController < ApplicationController
  before_action :set_property
  before_action :set_income, only: %i[ show update destroy ]

  def index
    @incomes = @property.incomes

    render json: @incomes
  end

  def show
    render json: @income
  end

  def create
    @income = @property.incomes.build(income_params)

    if @income.save
      render json: @income, status: :created, location: property_income_url(@property, @income)
    else
      render json: @income.errors, status: :unprocessable_entity
    end
  end

  def update
    if @income.update(income_params)
      render json: @income
    else
      render json: @income.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @income.destroy
  end

  private

  def set_income
    @income = @property.incomes.find(params[:id])
  end

  def set_property
    @property = Property.find(params[:property_id])
  end

  def income_params
    params.require(:income).permit(:amount, :type)
  end
end
