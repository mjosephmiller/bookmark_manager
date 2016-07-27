feature 'adding users' do
  scenario 'user signs up' do

    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, user@hotmail.com')
    expect(User.first.email).to eq('user@hotmail.com')
  end
end
