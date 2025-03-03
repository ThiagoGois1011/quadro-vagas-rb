describe 'User see message' do
    it 'with success', js: true do
      visit root_path

      expect(page).to have_content('Bem vindo ao quadro de vagas')
    end
end
