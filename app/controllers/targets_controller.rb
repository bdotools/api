class TargetsController < ApplicationController
  def index
    render json: targets, each_serializer: MiniTargetSerializer
  end

  def show
    target = Target.find(params[:id])

    render json: target
  end

  private

  def targets
    Target.eager_load(:category, :constellation, :knowledges).
      with_available_state.order(name: :asc)
  end
end
