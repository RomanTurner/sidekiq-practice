class Students::ExampleController < ApplicationController

  def pure_sidekiq_job
    Students::PureSidekiqJob.perform_async(params[:id])
  end

end
