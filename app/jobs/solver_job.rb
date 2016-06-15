class SolverJob < ApplicationJob
  queue_as :default

  def perform(id, interest, favor)
    pid = Process.spawn "bin/solver SolveFast \"#{id}\" #{interest} #{favor} 6"
    Process.wait pid
  end
end
