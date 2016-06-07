class TargetsController < ApplicationController
  def index
    render json: Target.with_available_state.order(name: :asc), each_serializer: MiniTargetSerializer
  end

  def show
    target = Target.eager_load(:category, :constellation, :knowledges).find(params[:id])

    render json: target
  end
end
