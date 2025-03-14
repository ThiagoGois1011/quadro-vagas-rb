require 'rails_helper'

describe 'user send a file', type: :system do
  it 'with success' do
    user = create(:user)

    login_as(user)
    visit root_path
    click_on 'Upload do script'
    attach_file 'Upload a file', Rails.root.join('spec/fixtures/script.txt')
    click_on 'Enviar'
    
    expect(current_path).to eq(bulk_status_path)
    expect(page).to have_content('Arquivo recebido com sucesso.')
  end
end