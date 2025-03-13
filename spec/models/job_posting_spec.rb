require 'rails_helper'

RSpec.describe JobPosting, type: :model do
  context "#Valid?" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:salary) }
    it { should validate_presence_of(:salary_currency) }
    it { should validate_presence_of(:salary_period) }
    it { should validate_presence_of(:work_arrangement) }
    it { should validate_presence_of(:description) }
    it { should belong_to :company_profile }
    it { should belong_to :job_type }
    it { should validate_presence_of(:description) }
    it { should belong_to :experience_level }

    it 'default value of status' do
      company_profile = create(:company_profile)
      job_type = create(:job_type)
      experience_level = create(:experience_level)
      job_posting = JobPosting.create!(title: 'Dev Ruby', salary: '2000', salary_currency: :usd, salary_period: :monthly,
                                       description: 'Uma descrição', company_profile: company_profile, job_type: job_type,
                                       experience_level: experience_level, work_arrangement: :remote)

      expect(job_posting.status).to eq('active')
    end
  end
end
