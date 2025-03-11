class JobPostingsController < ApplicationController
  allow_unauthenticated_access only: [:show]

  def index
    @job_postings = JobPosting.page(params[:page]).per(10)
  end

  def show
    @job_posting = JobPosting.find(params[:id])
  end
end
