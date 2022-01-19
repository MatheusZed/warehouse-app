require 'rails_helper'

describe 'User edits warehouse' do
  it 'Visitor not sees the menu' do
    # Arrange
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    wh = Warehouse.create!(
      name: 'Alimenticio', code: 'ALM', description: 'Otimo galpao numa linda cidade com luzes',
      address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL', postal_code:'57050-000',
      total_area: 10000, useful_area: 8000, product_category_ids: [pc.id]
    )

    # Act
    visit root_path

    # Assert
    expect(page).not_to have_link 'Edit'
  end

  it "Visitor don't access the form directly" do
    # Arrange
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    wh = Warehouse.create!(
      name: 'Alimenticio', code: 'ALM', description: 'Otimo galpao numa linda cidade com luzes',
      address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL', postal_code:'57050-000',
      total_area: 10000, useful_area: 8000, product_category_ids: [pc.id]
    )

    # Act
    visit edit_warehouse_path(wh.id)

    # Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'through the list screen' do
    # Arrange
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    wh1 = Warehouse.create!(
      name: 'Alimenticio', code: 'ALM', description: 'Otimo galpao numa linda cidade com luzes',
      address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL', postal_code:'57050-000',
      total_area: 10000, useful_area: 8000, product_category_ids: [pc.id]
    )
    wh2 = Warehouse.create!(
      name: 'Doces', code: 'DCS', description: 'Otimo galpao numa cheio de guloseimas com luzes',
      address: 'Av Fernandes Doces', city: 'Sao Paulo', state: 'SP', postal_code:'57051-000',
      total_area: 10000, useful_area: 8000, product_category_ids: [pc.id]
    )
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    #find("edit-#{wh1.id}").click
    click_on 'Edit', id: "edit-#{wh1.id}"

    # Assert
    expect(current_path).to eq edit_warehouse_path(wh1.id)
    expect(page).to have_content 'Edit Warehouse'
  end

  it 'successfully' do
    # Arrange
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    wh1 = Warehouse.create!(
      name: 'Alimenticio', code: 'ALM', description: 'Otimo galpao numa linda cidade com luzes',
      address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL', postal_code:'57050-000',
      total_area: 10000, useful_area: 8000, product_category_ids: [pc.id]
    )
    wh2 = Warehouse.create!(
      name: 'Doces', code: 'DCS', description: 'Otimo galpao numa cheio de guloseimas muito doce',
      address: 'Av Fernandes Doces', city: 'Sao Paulo', state: 'SP', postal_code:'57051-000',
      total_area: 10000, useful_area: 8000, product_category_ids: [pc.id]
    )
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Edit', id: "edit-#{wh1.id}"
    fill_in 'Nome',	with: 'Alimenticios'
    click_on 'Save'

    # Assert
    expect(current_path).to eq warehouse_path(wh1.id)
    expect(page).to have_content 'Successfully edited warehouse'
    expect(page).to have_content 'Alimenticios'
  end

  it "and can't edit" do
    # Arrange
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    wh1 = Warehouse.create!(
      name: 'Alimenticio', code: 'ALM', description: 'Otimo galpao numa linda cidade com luzes',
      address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL', postal_code:'57050-000',
      total_area: 10000, useful_area: 8000, product_category_ids: [pc.id]
    )
    wh2 = Warehouse.create!(
      name: 'Doces', code: 'DCS', description: 'Otimo galpao numa cheio de guloseimas muito doce',
      address: 'Av Fernandes Doces', city: 'Sao Paulo', state: 'SP', postal_code:'57051-000',
      total_area: 10000, useful_area: 8000, product_category_ids: [pc.id]
    )
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Edit', id: "edit-#{wh2.id}"
    fill_in 'CEP',	with: '570510-000'
    click_on 'Save'

    # Assert
    expect(page).not_to have_content 'Successfully edited warehouse'
    expect(page).to have_content "It wasn't possible to edit the warehouse"
    expect(page).to have_content 'CEP não é valido, formato: 00000-000'
    end
end
