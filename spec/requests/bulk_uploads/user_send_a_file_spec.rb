require 'rails_helper'

describe 'user send a file', type: :request do
  it 'but not an admin' do
    user = create(:user)

    login_as(user)
    post(bulk_uploads_path, params: { upload: Rails.root.join('spec/fixtures/script.txt')})

    expect(response).to redirect_to root_path
    expect(response.status).to eq 302
    expect(flash[:notice]).to eq('Essa página não existe.')
  end
  
  it 'but it is not authenticated' do
    post(bulk_uploads_path, params: { upload: Rails.root.join('spec/fixtures/script.txt')})

    expect(response).to redirect_to new_session_path
    expect(response.status).to eq 302
  end
end
