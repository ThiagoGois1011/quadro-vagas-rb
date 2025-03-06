require 'rails_helper'

describe 'User see message', js: true do
    it 'with success' do
      visit root_path
      click_on 'Clique aqui'

      expect(page).to have_content('Bem vindo ao quadro de vagas')
    end

    it 'without click' do
      visit root_path

      expect(page).not_to have_content('Bem vindo ao quadro de vagas')
    end
end
