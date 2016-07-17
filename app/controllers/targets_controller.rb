class TargetsController < ApplicationController
  def index
    targets = Target.with_available_state.reject { |x| x.name.nil? }.sort_by(&:name)

    render json: targets, each_serializer: MiniTargetSerializer
  end

  def show
    target = Target.eager_load(:category, :constellation, :knowledges).find(params[:id])

    render json: target
  end
end
