require 'rails_helper'

describe 'User edits warehouse' do
  let(:product_category) { create(:product_category) }

  it 'Visitor not sees the menu' do
    # Arrange
    create(:warehouse, product_category_ids:[product_category.id])

    # Act
    visit root_path

    # Assert
    expect(page).not_to have_link 'Edit'
  end

  it "Visitor don't access the form directly" do
    # Arrange
    wh = create(:warehouse, product_category_ids:[product_category.id])

    # Act
    visit edit_warehouse_path(wh.id)

    # Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'through the list screen' do
    # Arrange
    wh1 = create(:warehouse, product_category_ids:[product_category.id])
    wh2 = create(:warehouse, product_category_ids:[product_category.id])
    wh3 = create(:warehouse, product_category_ids:[product_category.id])
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    # find("edit-#{wh1.id}").click
    click_on 'Edit', id: "edit-#{wh2.id}"

    # Assert
    expect(current_path).to eq edit_warehouse_path(wh2.id)
    expect(page).to have_content 'Edit Warehouse'
  end

  it 'successfully' do
    # Arrange
    wh1 = create(:warehouse, product_category_ids:[product_category.id])
    wh2 = create(:warehouse, product_category_ids:[product_category.id])
    wh3 = create(:warehouse, product_category_ids:[product_category.id])
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
    wh1 = create(:warehouse, product_category_ids:[product_category.id])
    wh2 = create(:warehouse, product_category_ids:[product_category.id])
    wh3 = create(:warehouse, product_category_ids:[product_category.id])
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
