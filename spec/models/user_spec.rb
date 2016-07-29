describe User do

  let!(:user) do
    User.create(email: 'user@user.com', password: 'user', password_confirmation: 'user')
  end

  it 'authenticates when a user signs in with correct credentials' do
    authenticated_user = User.authenticate(user.email, user.password)
    expect(authenticated_user).to eq user
  end

  it 'does not authenticate when a user signs in with incorrect credentials' do
    expect(User.authenticate(user.email, '123456efds')).to be_nil
  end
end
