require 'rails_helper'

describe 'User sees a list of job postings', type: :system do
  it 'with success' do
    user = create(:user)
    create(:job_posting, title: 'Dev Ruby on Rails')
    create(:job_posting, title: 'Dev Front-End')

    visit root_path
    within('#nav-links') do
      click_on 'Vagas'
    end
    fill_in 'email_address', with: user.email_address
    fill_in 'password', with: user.password
    click_on 'Sign in'

    expect(page).to have_content('Dev Ruby on Rails')
    expect(page).to have_content('Dev Front-End')
  end

  it 'with an empty list' do
    user = create(:user)

    visit root_path
    within('#nav-links') do
      click_on 'Vagas'
    end
    fill_in 'email_address', with: user.email_address
    fill_in 'password', with: user.password
    click_on 'Sign in'

    expect(page).to have_content('Ainda não foi criado nenhuma vaga.')
  end

  it 'without logging in' do
    user = create(:user)
    create(:job_posting, title: 'Dev Ruby on Rails')
    create(:job_posting, title: 'Dev Front-End')

    visit root_path
    within('#nav-links') do
      click_on 'Vagas'
    end

    expect(page).to have_content('Sign in')
    expect(page).to have_content('Forgot password?')
  end

  # Está faltando o de autorização 
end