require 'rails_helper'

describe 'User edit a job posting', type: :system do
  it 'with success', js: true do
    user = create(:user)
    company_profile = create(:company_profile, user: user)
    job_posting = create(:job_posting, company_profile: company_profile, title: 'Dev Ruby')
    job_type = create(:job_type, name: 'Part time')
    experience = create(:experience_level, name: 'Junior')

    login_as user
    visit root_path
    click_on 'Dev Ruby'
    click_on 'Editar'
    fill_in 'Título', with: 'Desenvolvedor Backend'
    select 'Semanal', from: 'Período do salário'
    select 'BRL', from: 'Moeda'
    fill_in 'Salário', with: '200000'
    select 'Part time', from: 'Tipo de trabalho'
    select 'Remoto', from: 'Arranjo de trabalho'
    select 'Junior', from: 'Nível de experiência'
    find('trix-editor').click.set("teste")
    click_on 'Salvar'

    expect(page).to have_content('Anúncio atualizado com sucesso.')
    expect(current_path).to eq(job_posting_path(job_posting))
    expect(page).to have_content('Desenvolvedor Backend')
    expect(page).to have_content('Tipo de trabalho: Part time')
    expect(page).to have_content('Salário: 2000.00')
    expect(page).to have_content('Período do salário: Semanal')
    expect(JobPosting.first.description.to_plain_text).to eq('teste')
  end
end
