require 'rails_helper'

describe 'user send a file', type: :system do
  it 'with success' do
    user = create(:user, role: :admin)

    login_as(user)
    visit root_path
    click_on 'Gerar Dados'
    attach_file 'Enviar Arquivo', Rails.root.join('spec/fixtures/script.txt')
    click_on 'Enviar'

    expect(current_path).to eq(bulk_status_path)
    expect(page).to have_content('Arquivo recebido com sucesso.')
  end

  it 'with nothing' do
    user = create(:user, role: :admin)

    login_as(user)
    visit root_path
    click_on 'Gerar Dados'
    click_on 'Enviar'

    expect(current_path).to eq(bulk_uploads_path)
    expect(page).to have_content('É necessário enviar um arquivo.')
  end

  it 'with an invalid file type' do
    user = create(:user, role: :admin)

    login_as(user)
    visit root_path
    click_on 'Gerar Dados'
    attach_file 'Enviar Arquivo', Rails.root.join('spec/support/files/logo.jpeg')
    click_on 'Enviar'

    expect(current_path).to eq(bulk_uploads_path)
    expect(page).to have_content('O tipo do arquivo não é aceito.')
  end

  it 'but it is not authenticated' do
    user = create(:user, role: :admin)

    visit new_bulk_upload_path

    expect(current_path).to eq(new_session_path)
    expect(page).to have_content('Sign in')
    expect(page).to have_content('Forgot password?')
  end

  it 'but not an admin' do
    user = create(:user)

    login_as(user)
    visit new_bulk_upload_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Essa página não existe.')
  end
end
