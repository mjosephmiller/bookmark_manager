feature 'viewing links' do

  before(:each) do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy', tag: [Tag.first_or_create(name: 'education')])
    Link.create(url: 'http://facebook.com', title: 'Facebook', tag: [Tag.first_or_create(name: 'social')])
    Link.create(url: 'http://bubble.com', title: 'Bubble Bubble', tag: [Tag.first_or_create(name: 'bubbles')])
  end

  scenario 'I can see existing links on the links page' do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')

    visit '/links'
    expect(page.status_code).to eq 200

    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
  end

    scenario 'user can filter links by tags' do
      visit '/tag/bubbles'
      expect(page).not_to have_content('Makers Academy')
      expect(page).to have_content('Bubble Bubble')
    end

end
