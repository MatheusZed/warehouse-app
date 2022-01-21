require 'rails_helper'

describe 'User navigates' do
  let(:pc) { create(:product_category) }

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
      create(:warehouse, name: "Alimenticio", code: "ALM", product_category_ids: [pc.id])
      create(:warehouse, name: "Salgados", code: "SLG", product_category_ids: [pc.id])
      create(:warehouse, name: "Refrigerados", code: "RFG", product_category_ids: [pc.id])
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
      create(:warehouse, name: "Alimenticio", code: "ALO", product_category_ids: [pc.id])
      create(:warehouse, name: "Salgados", code: "SLO", product_category_ids: [pc.id])
      create(:warehouse, name: "Refrigerados", code: "RFG", product_category_ids: [pc.id])
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
      create(
        :warehouse, name: "Alimenticio", code: "ALO", address: "Av Calsadao", city: "Osasco",
        description: "Otimo galpao", state: "SP", product_category_ids: [pc.id]
      )
      create(
        :warehouse, name: "Salgados", code: "SLO", address: "Av Fernandes Lima", city: "Maceio",
        description: "Exelente galpao", state: "AL", product_category_ids: [pc.id]
      )
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
      expect(page).to have_content 'Descrição: Exelente galpao'
      expect(page).to have_content 'Endereço: Av Fernandes Lima-Maceio/AL'
      expect(page).to have_content 'Categorias aceitas no galpao'
      expect(page).to have_content pc.name
      expect(page).not_to have_css 'h1', text: 'Alimenticio'
      expect(page).not_to have_css 'h1', text: 'ALO'
      expect(page).not_to have_content 'Descrição: Otimo galpao'
      expect(page).not_to have_content 'Endereço: Av Calsadao-Osasco/SP'
    end

    pending "and can't search if label is empty" do
      # Arrange
      create(:warehouse, name: "Alimenticio", code: "ALO", product_category_ids: [pc.id])
      create(:warehouse, name: "Salgados", code: "SLO", product_category_ids: [pc.id])
      create(:warehouse, name: "Refrigerados", code: "RFG", product_category_ids: [pc.id])
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
