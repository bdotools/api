class TargetsController < ApplicationController
  def index
    render json: targets, each_serializer: MiniTargetSerializer
  end

  def show
    target = Target.eager_load(:category, :constellation, :knowledges, :results).find(params[:id])

    render json: target
  end

  private

  def targets
    Target.joins(:results).where.not(results: { id: nil }).uniq
  end
end
