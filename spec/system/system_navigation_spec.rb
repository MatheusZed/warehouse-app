require 'rails_helper'

describe 'User navigates' do
  it 'and returns to the home page by clicking on the icon' do
    # Act
    visit suppliers_path
    click_on 'icon'

    # Assert
    expect(current_path).to eq root_path
  end

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

  it 'and user can see search bar' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path

    # Assert
    expect(page).to have_field 'search-input'
    expect(page).to have_button 'Search'
  end
  
  context 'and search for warehouse' do  
    it 'successfully by name' do
      # Arrange
      Warehouse.create!(name: 'Alimenticio', code: 'ALM', description: 'Otimo galpao numa linda cidade',
                        address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                        postal_code:'57050-000', total_area: 10000, useful_area: 8000)
      Warehouse.create!(name: 'Salgados', code: 'SLG', description: 'Otimo galpao numa linda cidade',
                        address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                        postal_code:'57050-000', total_area: 10000, useful_area: 8000)
      Warehouse.create!(name: 'Refrigerados', code: 'RFG', description: 'Otimo galpao numa linda cidade',
                        address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                        postal_code:'57050-000', total_area: 10000, useful_area: 8000)                      
      user = User.create!(email: 'joao@email.com', password: 'admino')

      # Act
      login_as(user, scope: :user)
      visit suppliers_path
      fill_in 'search-input',	with: 'dos'
      click_on 'Search'

      # Assert
      expect(page).to have_css 'h1', text: 'Search results'
      expect(page).to have_content 'Salgados'
      expect(page).to have_content 'SLG'
      expect(page).to have_content 'Refrigerados'
      expect(page).to have_content 'RFG'
      expect(page).not_to have_content 'Alimenticio'
      expect(page).not_to have_content 'ALM'
    end

    it 'successfully by code' do
      # Arrange
      Warehouse.create!(name: 'Alimenticio', code: 'ALO', description: 'Otimo galpao numa linda cidade',
                        address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                        postal_code:'57050-000', total_area: 10000, useful_area: 8000)
      Warehouse.create!(name: 'Salgados', code: 'SLO', description: 'Otimo galpao numa linda cidade',
                        address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                        postal_code:'57050-000', total_area: 10000, useful_area: 8000)
      Warehouse.create!(name: 'Refrigerados', code: 'RFG', description: 'Otimo galpao numa linda cidade',
                        address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                        postal_code:'57050-000', total_area: 10000, useful_area: 8000)                      
      user = User.create!(email: 'joao@email.com', password: 'admino')

      # Act
      login_as(user, scope: :user)
      visit suppliers_path
      fill_in 'search-input',	with: 'LO'
      click_on 'Search'
      
      # Assert
      expect(page).to have_css 'h1', text: 'Search results'
      expect(page).to have_css '#src', text: 'Alimenticio'
      expect(page).to have_css '#src', text: 'ALO'
      expect(page).to have_css '#src', text: 'Salgados'
      expect(page).to have_css '#src', text: 'SLO'
      expect(page).not_to have_css '#src', text: 'Refrigerados'
      expect(page).not_to have_css '#src', text: 'RFG'
    end

    it 'and can go to warehouse trought the link in name' do
      # Arrange
      Warehouse.create!(name: 'Alimenticio', code: 'ALO', description: 'Otimo galpao numa cidade tranquila',
                        address: 'Av Calsadao', city: 'Osasco', state: 'SP',
                        postal_code:'57050-000', total_area: 10000, useful_area: 8000)
      Warehouse.create!(name: 'Salgados', code: 'SLO', description: 'Otimo galpao numa linda cidadee',
                        address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                        postal_code:'57051-000', total_area: 1000, useful_area: 800)
      user = User.create!(email: 'joao@email.com', password: 'admino')

      # Act
      login_as(user, scope: :user)
      visit suppliers_path
      fill_in 'search-input',	with: 'LO'
      click_on 'Search'
      click_on 'Salgados'

      # Assert
      expect(page).to have_css 'h1', text: 'Salgados'
      expect(page).to have_css 'h1', text: 'SLO'
      expect(page).to have_content 'Descrição: Otimo galpao numa linda cidadee'
      expect(page).to have_content 'Endereço: Av Fernandes Lima-Maceio/AL'
      expect(page).to have_content 'CEP: 57051-000'
      expect(page).to have_content 'Area Total: 1000'
      expect(page).to have_content 'Area Util: 800'
      expect(page).not_to have_css 'h1', text: 'Alimenticio'
      expect(page).not_to have_css 'h1', text: 'ALO'
      expect(page).not_to have_content 'Descrição: Otimo galpao numa cidade tranquila'
      expect(page).not_to have_content 'Endereço: Av Calsadao-Osasco/SP'
      expect(page).not_to have_content 'CEP: 57050-000'
      expect(page).not_to have_content 'Area Total: 10000'
      expect(page).not_to have_content 'Area Util: 8000'      
    end

    pending "and can't search if label is empty" do
      # Arrange
      Warehouse.create!(name: 'Alimenticio', code: 'ALO', description: 'Otimo galpao numa linda cidade',
                        address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                        postal_code:'57050-000', total_area: 10000, useful_area: 8000)
      Warehouse.create!(name: 'Salgados', code: 'SLO', description: 'Otimo galpao numa linda cidade',
                        address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                        postal_code:'57050-000', total_area: 10000, useful_area: 8000)
      Warehouse.create!(name: 'Refrigerados', code: 'RFG', description: 'Otimo galpao numa linda cidade',
                        address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                        postal_code:'57050-000', total_area: 10000, useful_area: 8000)                      
      user = User.create!(email: 'joao@email.com', password: 'admino')

      # Act
      login_as(user, scope: :user)
      visit root_path

      # Assert
      disabled = page.evaluate_script("$('#search-id').attr('disabled');")
      disabled.should == 'disabled'
    end
  end
end
