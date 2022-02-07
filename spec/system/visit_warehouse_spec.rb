require 'rails_helper'

describe 'Visitor sees the warehouse' do
  let(:pc) { create(:product_category, name: "Conservados") }

  it 'and sees all registered data' do
    # Arrange
    create(
      :warehouse, name: "Osasco", code: "OZS", description: "Otimo galpao numa linda cidade",
      address: "Av Fernandes Lima", city: "Maceio", state: "AL", postal_code: "57050-000",
      total_area: 10_000, useful_area: 8000, product_category_ids: [pc.id]
    )

    # Act
    visit root_path
    click_on 'Osasco'

    # Assert
    expect(page).to have_content 'Osasco'
    expect(page).to have_content 'OZS'
    expect(page).to have_content 'Descrição: Otimo galpao numa linda cidade'
    expect(page).to have_content 'Endereço: Av Fernandes Lima-Maceio/AL'
    expect(page).to have_content 'CEP: 57050-000'
    expect(page).to have_content 'Area Total: 10000 m2'
    expect(page).to have_content 'Area Util: 8000 m2'
    expect(page).to have_content 'Categorias aceitas no galpao'
    expect(page).to have_content 'Conservados'
  end

  it 'and can return to home page' do
    # Arrange
    create(:warehouse, name: "Osasco", product_category_ids: [pc.id])

    # Act
    visit root_path
    click_on 'Osasco'
    click_on 'Return'

    # Assert
    expect(current_path).to eq root_path
  end

  context 'User enter new items' do
    let!(:supplier) { create(:supplier) }
    let!(:warehouse) { create(:warehouse, name: "Alimenticio", code: "ALM", product_category_ids: [pc.id]) }
    
    it 'Successfully throught the warehouse screen' do
      # Arrange
      pm1 = create(:product_model, name: "Migalhas de pao", supplier: supplier, product_category: pc)
      pm2 = create(:product_model, name: "Osso de Frango", supplier: supplier, product_category: pc)
      pm3 = create(:product_model, name: "Doces", supplier: supplier, product_category: pc)
      user = User.create!(email: 'joao@email.com', password: 'admino')

      # Act
      login_as(user, scope: :user)
      visit root_path
      click_on 'Alimenticio'
      within("div#add") do
        fill_in 'Quantidade', with: 100
        select 'Doces', from: 'Produto'
        click_on 'Save'
      end

      # Assert
      expect(current_path).to eq warehouse_path(warehouse.id)
      expect(page).to have_css('h2', text: 'Estoque')
      within("div#product-#{pm3.id}") do
        expect(page).to have_content('Doces')
        expect(page).to have_content('Quantidade: 100')
      end
    end

    it "and quantity can't be less than 0 throught the warehouse screen" do
      # Arrange
      pm1 = create(:product_model, name: "Migalhas de pao", supplier: supplier, product_category: pc)
      pm2 = create(:product_model, name: "Osso de Frango", supplier: supplier, product_category: pc)
      pm3 = create(:product_model, name: "Doces", supplier: supplier, product_category: pc)
      user = User.create!(email: 'joao@email.com', password: 'admino')
  
      # Act
      login_as(user, scope: :user)
      visit root_path
      click_on 'Alimenticio'
      within("div#add") do
        fill_in 'Quantidade', with: 0
        select 'Doces', from: 'Produto'
        click_on 'Save'
      end
  
      # Assert
      expect(page).not_to have_content 'Successfully registered items'
      expect(page).to have_content "It wasn't possible to record the items"
      expect(page).to have_content 'Quantidade nao pode ser 0 ou menor'
    end

    it 'and removes some amounts of product to fix storage' do
      # Arrange
      pm = create(:product_model,name: 'Saco de Feijao', supplier: supplier, product_category: pc)
      create_list(:product_item, 10, warehouse: warehouse, product_model: pm)
      user = User.create!(email: 'joao@email.com', password: 'admino')
  
      # Act
      login_as(user, scope: :user)
      visit root_path
      click_on 'Alimenticio'
      within("div#remove") do
        fill_in 'Quantidade', with: 2
        select 'Saco de Feijao', from: 'Produto'
        click_on 'Save'
      end
  
      # Assert
      expect(page).to have_content 'Successfully removed items. Quantity: 2'
      within("div#product-#{pm.id}") do
        expect(page).to have_content('Saco de Feijao')
        expect(page).to have_content('Quantidade: 8')
      end
    end

    it 'and tries to remove 0 products and fails' do
      # Arrange
      pm = create(:product_model,name: 'Saco de Feijao', supplier: supplier, product_category: pc)
      create_list(:product_item, 10, warehouse: warehouse, product_model: pm)
      user = User.create!(email: 'joao@email.com', password: 'admino')
  
      # Act
      login_as(user, scope: :user)
      visit root_path
      click_on 'Alimenticio'
      within("div#remove") do
        fill_in 'Quantidade', with: 0
        select 'Saco de Feijao', from: 'Produto'
        click_on 'Save'
      end
  
      # Assert
      expect(page).to have_content "It wasn't possible to remove the items"
      expect(page).to have_content 'Quantidade nao pode ser 0 ou menor'
      within("div#product-#{pm.id}") do
        expect(page).to have_content('Saco de Feijao')
        expect(page).to have_content('Quantidade: 10')
      end
    end

    it 'and tries to remove more products than is registered' do
      # Arrange
      pm = create(:product_model,name: 'Saco de Feijao', supplier: supplier, product_category: pc)
      create_list(:product_item, 10, warehouse: warehouse, product_model: pm)
      user = User.create!(email: 'joao@email.com', password: 'admino')
  
      # Act
      login_as(user, scope: :user)
      visit root_path
      click_on 'Alimenticio'
      within("div#remove") do
        fill_in 'Quantidade', with: 11
        select 'Saco de Feijao', from: 'Produto'
        click_on 'Save'
      end
  
      # Assert
      expect(page).to have_content "It wasn't possible to remove the items"
      expect(page).to have_content 'Quantidade nao pode ser maior que o numero de itens cadastrados'
      within("div#product-#{pm.id}") do
        expect(page).to have_content('Saco de Feijao')
        expect(page).to have_content('Quantidade: 10')
      end
    end
  end
end
