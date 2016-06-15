class SolverJob < ApplicationJob
  queue_as :default

  def perform(name, interest, favor)
    pid = Process.spawn "bin/solver SolveFast \"#{target.name}\" #{interest} #{favor} 6"
    Process.wait pid
  end
end
