class QueryController < ApplicationController
  FAIL_PARAMS = [1, 3]

  def show
    order = fail_params.include?(params[:g].to_i) ? :asc : :desc

    result = BestCombo.new(id: params[:t], order: order, interest: params[:i])
    render json: result
  end

  private

  def fail_params
    FAIL_PARAMS.freeze
  end
end
