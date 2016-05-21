class TargetsController < ApplicationController
  def index
    targets = Target.eager_load(:category, :constellation, :knowledges).order(name: :asc).all

    render json: targets, each_serializer: MiniTargetSerializer
  end

  def show
    target = Target.find(params[:id])

    render json: target
  end
end
