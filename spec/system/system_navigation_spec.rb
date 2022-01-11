require 'rails_helper'

describe 'User navigates' do
  it 'using the menu' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path

    # Assert 1
    expect(page).to have_css 'nav a', text: 'Home'
    expect(page).to have_css 'nav a', text: 'Register new warehouse'
    expect(page).to have_css 'nav a', text: 'Register new supplier'
    expect(page).to have_css 'nav a', text: 'See suppliers'
    expect(page).to have_css 'nav a', text: 'Register new product category'
    expect(page).to have_css 'nav a', text: 'Register new product model'
    expect(page).to have_css 'nav a', text: 'Register new product bundle'
    expect(page).to have_css 'nav a', text: 'Enter new items'


    # Assert 2
    within 'nav' do
      expect(page).to have_link 'Home', href: root_path
      expect(page).to have_link 'Register new warehouse', href: new_warehouse_path
      expect(page).to have_link 'Register new supplier', href: new_supplier_path
      expect(page).to have_link 'See suppliers', href: suppliers_path
      expect(page).to have_link 'Register new product category', href: new_product_category_path
      expect(page).to have_link 'Register new product model', href: new_product_model_path
      expect(page).to have_link 'Register new product bundle', href: new_product_bundle_path
      expect(page).to have_link 'Enter new items', href: product_items_entry_path
    end
  end
end
