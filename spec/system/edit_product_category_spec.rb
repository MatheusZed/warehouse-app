require 'rails_helper'

describe 'User edits product category' do
  it 'Visitor not sees the menu' do
    # Arrange
    ProductCategory.create!(name: 'Enlatados')
    ProductCategory.create!(name: 'Congelados')

    # Act
    visit root_path
    click_on 'See product categories'

    # Assert
    expect(page).not_to have_link 'Edit'
  end

  it "Visitor don't access the form directly" do
    # Arrange
    pc = ProductCategory.create!(name: 'Enlatados')

    # Act
    visit edit_product_category_path(pc.id)

    # Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'through the list screen' do
    # Arrange
    pc1 = ProductCategory.create!(name: 'Enlatados')
    pc2 = ProductCategory.create!(name: 'Congelados')
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'See product categories'
    click_on 'Edit', id: "edit-#{pc1.id}"

    # Assert
    expect(current_path).to eq edit_product_category_path(pc1.id)
    expect(page).to have_content 'Edit Product Category'
  end

  it 'successfully' do
    # Arrange
    pc1 = ProductCategory.create!(name: 'Enlatados')
    pc2 = ProductCategory.create!(name: 'Congelados')
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'See product categories'
    click_on 'Edit', id: "edit-#{pc2.id}"
    fill_in 'Nome',	with: 'Quentes'
    click_on 'Save'

    # Assert
    expect(current_path).to eq product_categories_path
    expect(page).to have_content 'Successfully edited product category'
    expect(page).to have_content 'Quentes'
  end

  it "and can't edit" do
    # Arrange
    pc1 = ProductCategory.create!(name: 'Enlatados')
    pc2 = ProductCategory.create!(name: 'Congelados')
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'See product categories'
    click_on 'Edit', id: "edit-#{pc1.id}"
    fill_in 'Nome',	with: ''
    click_on 'Save'

    # Assert
    expect(page).not_to have_content 'Successfully edited product category'
    expect(page).to have_content "It wasn't possible to edit the product category"
    expect(page).to have_content 'Nome não pode ficar em branco'
  end
end
