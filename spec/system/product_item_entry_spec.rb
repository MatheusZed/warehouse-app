require 'rails_helper'

describe 'User enter new items' do
  let!(:supplier) { create(:supplier) }
  let!(:pc) { create(:product_category, name: "Conservados") }
  let!(:warehouse) { create(:warehouse, name: "Alimenticio", code: "ALM", product_category_ids: [pc.id]) }

  it 'Visitor not sees the menu' do
    # Act
    visit root_path

    # Assert
    expect(page).not_to have_link 'Enter new items'
  end

  it "Visitor don't access the form directly" do
    # Act
    visit product_items_entry_path

    # Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'throught the link in homepage' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Enter new items'

    # Assert
    expect(page).to have_content 'Log batch entry'
    expect(page).to have_field 'Quantidade'
    expect(page).to have_field 'Galpao Destino'
    expect(page).to have_field 'Produto'
    expect(page).to have_button 'Save'
  end

  it 'Successfully' do
    # Arrange
    pm1 = create(:product_model, name: "Migalhas de pao", supplier: supplier, product_category: pc)
    pm2 = create(:product_model, name: "Osso de Frango", supplier: supplier, product_category: pc)
    pm3 = create(:product_model, name: "Doces", supplier: supplier, product_category: pc)
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Enter new items'
    fill_in 'Quantidade', with: 100
    select 'ALM', from: 'Galpao Destino'
    select 'Doces', from: 'Produto'
    click_on 'Save'

    # Assert
    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_content 'Successfully registered items'
    expect(page).to have_css('h2', text: 'Estoque')
    within("div#product-#{pm3.id}") do
      expect(page).to have_content('Doces')
      expect(page).to have_content('Quantidade: 100')
    end
  end

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
    fill_in 'Quantidade', with: 100
    select 'Doces', from: 'Produto'
    click_on 'Save'

    # Assert
    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_css('h2', text: 'Estoque')
    within("div#product-#{pm3.id}") do
      expect(page).to have_content('Doces')
      expect(page).to have_content('Quantidade: 100')
    end
  end

  it "and quantity can't be less than 0" do
    # Arrange
    pm1 = create(:product_model, name: "Migalhas de pao", supplier: supplier, product_category: pc)
    pm2 = create(:product_model, name: "Osso de Frango", supplier: supplier, product_category: pc)
    pm3 = create(:product_model, name: "Doces", supplier: supplier, product_category: pc)
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Enter new items'
    fill_in 'Quantidade', with: 0
    select 'ALM', from: 'Galpao Destino'
    select 'Doces', from: 'Produto'
    click_on 'Save'

    # Assert
    expect(page).not_to have_content 'Successfully registered items'
    expect(page).to have_content "It wasn't possible to record the items"
    expect(page).to have_content 'Quantidade nao pode ser 0 ou menor'
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
    fill_in 'Quantidade', with: 0
    select 'Doces', from: 'Produto'
    click_on 'Save'

    # Assert
    expect(page).not_to have_content 'Successfully registered items'
    expect(page).to have_content "It wasn't possible to record the items"
    expect(page).to have_content 'Quantidade nao pode ser 0 ou menor'
  end

  it "and category in warehouse and product_bundle can't be different " do
    # Arrange
    pc2 = create(:product_category, name: "Enlatados")
    pm1 = create(:product_model, name: "Migalhas de pao", supplier: supplier, product_category: pc2)
    pm2 = create(:product_model, name: "Osso de Frango", supplier: supplier, product_category: pc2)
    pm3 = create(:product_model, name: "Doces", supplier: supplier, product_category: pc2)
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Enter new items'
    fill_in 'Quantidade', with: 100
    select 'ALM', from: 'Galpao Destino'
    select 'Doces', from: 'Produto'
    click_on 'Save'

    # Assert
    expect(page).to have_content 'Nao foi possivel salvar estoque, categoria de modelo de produto incompativel com categoria de galpao'
  end

  it 'and product model must be actived' do
    # Arrange
    create(:product_model, name: "Migalhas de pao", status: 1, supplier: supplier, product_category: pc)
    create(:product_model, name: "Doces", supplier: supplier, product_category: pc)
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Enter new items'

    # Assert
    expect(page).to have_select('Produto', options:['Doces'])
  end
end
