require 'rails_helper'

describe 'Visitor navigates' do
  it 'using the menu' do
    visit root_path

    #Assert 1
    expect(page).to have_css 'nav a', text: 'Home'
    expect(page).to have_css 'nav a', text: 'Register new warehouse'

    #Assert 2
    within 'nav' do
      expect(page).to have_link 'Home', href: root_path
      expect(page).to have_link 'Register new warehouse', href: new_warehouse_path
    end
  end
end