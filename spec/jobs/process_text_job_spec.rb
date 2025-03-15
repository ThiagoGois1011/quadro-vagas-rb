require 'rails_helper'

RSpec.describe ProcessTxtJob, type: :job do
  it 'cria lista de teste' do
    file_path = Rails.root.join('spec/fixtures/script.txt')
    ProcessTxtJob.perform_later(file_path.to_s)

    expect(enqueued_jobs.size).to eq(1)
  end

  it 'checa os resultados' do
    user = create(:user)
    user_for_job = create(:user, email_address: 'thiago@email.com')
    company = create(:company_profile, user: user)
    job_type = create(:job_type)
    experience_level = create(:experience_level)
    file_path = Rails.root.join('spec/fixtures/script_job.txt')
    File.open(file_path, "w") do |file|
      file.puts "U,usuario2@example.com,Nome do usuario,sobrenome,password123"
      file.puts "E,Empresa A,https://www.empresa-a.com,contato@empresa-a.com,#{user_for_job.id}"
      file.puts "V,Desenvolvedor Ruby on Rails,5000,BRL,Mensal,Presencial,#{job_type.id},São Paulo,#{experience_level.id},#{company.id},descrição da vaga"
    end

    ProcessTxtJob.perform_later(file_path.to_s)
    perform_enqueued_jobs
    perform_enqueued_jobs
    File.delete(file_path) if File.exist?(file_path)

    expect(User.count).to eq(3)
    user_from_job = User.last
    expect(user_from_job.attributes.deep_symbolize_keys).to include({ email_address: 'usuario2@example.com', name: 'Nome do usuario',
                                                                      last_name: 'sobrenome' })
    expect(CompanyProfile.count).to eq(2)
    company_profile_from_job = CompanyProfile.last
    expect(company_profile_from_job.attributes.deep_symbolize_keys).to include({ name: 'Empresa A', website_url: 'https://www.empresa-a.com',
                                                                                 contact_email: 'contato@empresa-a.com', user_id: user_for_job.id })
    expect(JobPosting.count).to eq(1)
    job_posting_from_job = JobPosting.first
    expect(job_posting_from_job.attributes.deep_symbolize_keys).to include({ title: 'Desenvolvedor Ruby on Rails', salary: BigDecimal('5000'),
                                                                             salary_currency: 'brl', salary_period: 'monthly', work_arrangement: 'in_person',
                                                                             job_type_id: job_type.id, experience_level_id: experience_level.id,
                                                                             job_location: 'São Paulo', company_profile_id: company.id })
    expect(job_posting_from_job.description.to_plain_text).to eq('descrição da vaga')
  end
end
