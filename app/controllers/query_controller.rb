class QueryController < ApplicationController
  def show
    result = Result.find_by!(
      target_id: params[:t],
      goal: params[:g],
      goal_param: params[:gp],
      target_favor: params[:f],
      target_interest: params[:i]
    )

    render json: result
  end
end
