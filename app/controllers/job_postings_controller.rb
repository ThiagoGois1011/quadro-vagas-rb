class JobPostingsController < ApplicationController
  def index
    @job_postings = JobPosting.page(params[:page]).per(10)
  end
end