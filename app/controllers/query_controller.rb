class QueryController < ApplicationController
  FAIL_PARAMS = [1, 3]

  def show
    result = Result.find_by(
      target_id: params[:t],
      goal: params[:g],
      goal_param: params[:gp],
      target_favor: params[:f],
      target_interest: params[:i]
    )

    if !result
      order = fail_params.include?(params[:g].to_i) ? :asc : :desc
      result = BestCombo.new(id: params[:t], order: order, interest: params[:i], favor: params[:f])
    end

    render json: result
  end

  private

  def fail_params
    FAIL_PARAMS.freeze
  end
end
