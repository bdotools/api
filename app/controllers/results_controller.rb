class ResultsController < ApplicationController
  before_action :find_result
  before_action :has_voted_before?

  def up
    @result.votes.create(ip: user_ip, value: 1)
  end

  def down
    @result.votes.create(ip: user_ip, value: -1)
  end

  private

  def find_result
    @result = Result.find(params[:id])
  end

  def has_voted_before?
    if @result.votes.where(ip: user_ip).any?
      render :too_many_requests
    end
  end

  def user_ip
    request.remote_ip
  end
end
