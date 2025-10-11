class HomeController < ApplicationController
  def index
    @total_applications = JobApplication.count
    @active_applications = JobApplication.active.count
    @statistics = JobApplication.statistics if @total_applications > 0
  end
end
