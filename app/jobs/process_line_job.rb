class ProcessLineJob < ApplicationJob
  queue_with_priority :default

  USER_INDEX_EMAIL = 1
  USER_INDEX_NAME = 2
  USER_INDEX_LAST_NAME = 3
  USER_INDEX_PASSWORD = 4

  COMPANY_PROFILE_INDEX_NAME = 1
  COMPANY_PROFILE_INDEX_WEB_SITE = 2
  COMPANY_PROFILE_INDEX_CONTACT_EMAIL = 3
  COMPANY_PROFILE_INDEX_USER = 4

  JOB_POSTING_INDEX_TITLE = 1
  JOB_POSTING_INDEX_SALARY = 2
  JOB_POSTING_INDEX_SALARY_CURRENCY = 3
  JOB_POSTING_INDEX_SALARY_PERIOD = 4
  JOB_POSTING_INDEX_WORK_ARRANGEMENT = 5
  JOB_POSTING_INDEX_JOB_TYPE = 6
  JOB_POSTING_INDEX_JOB_LOCATION = 7
  JOB_POSTING_INDEX_EXPERIENCE_LEVEL = 8
  JOB_POSTING_INDEX_COMPANY_PROFILE = 9
  JOB_POSTING_INDEX_DESCRIPTION = 10

  def perform(line)
    return if line.blank?
    line_striped = line.strip
    action = line_striped[0]
    data = line_striped.split(",")

    case action
    when "U"
      create_user(data)
    when "E"
      create_company_profile(data)
    when "V"
      create_job_posting(data)
    else
      Rails.logger.error("Linha inválida: #{line}")
    end
  rescue StandardError => e
    Rails.logger.error("Erro ao processar linha: #{line} - #{e.message}")
  end

  private

  def create_user(data)
    User.create(email_address: data[USER_INDEX_EMAIL], name: data[USER_INDEX_NAME],
                    last_name: data[USER_INDEX_LAST_NAME], password: data[USER_INDEX_PASSWORD],
                    password_confirmation: data[USER_INDEX_PASSWORD])
  end

  def create_company_profile(data)
    company = CompanyProfile.new(name: data[COMPANY_PROFILE_INDEX_NAME], contact_email: data[COMPANY_PROFILE_INDEX_CONTACT_EMAIL],
                                 website_url: data[COMPANY_PROFILE_INDEX_WEB_SITE], user_id: data[COMPANY_PROFILE_INDEX_USER])
    company.logo.attach(io: File.open(Rails.root.join("spec/support/files/logo.jpg")), filename: "logo.jpg")
    company.save
  end

  def create_job_posting(data)
    salary_currency = data[JOB_POSTING_INDEX_SALARY_CURRENCY].downcase.to_sym
    salary_period = JobPosting.translate_enum(data[JOB_POSTING_INDEX_SALARY_PERIOD], "salary_periods", :'pt-BR', :en)
    work_arrangement = JobPosting.translate_enum(data[JOB_POSTING_INDEX_WORK_ARRANGEMENT], "work_arrangements", :'pt-BR', :en)
    JobPosting.create(title: data[JOB_POSTING_INDEX_TITLE], company_profile_id: data[JOB_POSTING_INDEX_COMPANY_PROFILE],
                      job_type_id: data[JOB_POSTING_INDEX_JOB_TYPE], experience_level_id: data[JOB_POSTING_INDEX_EXPERIENCE_LEVEL],
                      salary: data[JOB_POSTING_INDEX_SALARY], salary_currency: salary_currency, salary_period: salary_period.downcase.to_sym,
                      work_arrangement: work_arrangement.downcase.to_sym, job_location: data[JOB_POSTING_INDEX_JOB_LOCATION],
                      description: data[JOB_POSTING_INDEX_DESCRIPTION])
  end
end
