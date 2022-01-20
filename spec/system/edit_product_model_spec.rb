require 'rails_helper'

describe 'User edits product model' do
  it 'Visitor not sees the menu' do
    # Arrange
    s = Supplier.create!(
      fantasy_name: 'Maria', legal_name: 'Maria e os doces',
      cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
      email: 'maria.doceria@yahoo.com', phone: '91124-2855'
    )
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    ProductModel.create!(
      name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
      length: 22, supplier: s, product_category: pc
    )

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'

    # Assert
    expect(page).not_to have_link 'Edit'
  end

  it "Visitor don't access the form directly" do
    # Arrange
    s = Supplier.create!(
      fantasy_name: 'Maria', legal_name: 'Maria e os doces',
      cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
      email: 'maria.doceria@yahoo.com', phone: '91124-2855'
    )
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    ProductModel.create!(
      name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
      length: 22, supplier: s, product_category: pc
    )

    # Act
    visit edit_product_model_path(s.id)

    # Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'through the list screen' do
    # Arrange
    s = Supplier.create!(
      fantasy_name: 'Maria', legal_name: 'Maria e os doces',
      cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
      email: 'maria.doceria@yahoo.com', phone: '91124-2855'
    )
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    p1 = ProductModel.create!(
      name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
      length: 22, supplier: s, product_category: pc
    )
    p2 = ProductModel.create!(
      name: 'Osso de Galinha', weight: 20, height: 4, width: 5,
      length: 5, supplier: s, product_category: pc
    )
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'
    click_on 'Edit', id: "edit_pm-#{p1.id}"

    # Assert
    expect(current_path).to eq edit_product_model_path(p1.id)
    expect(page).to have_content 'Edit Product Model'
  end

  it 'successfully' do
    # Arrange
    s = Supplier.create!(
      fantasy_name: 'Maria', legal_name: 'Maria e os doces',
      cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
      email: 'maria.doceria@yahoo.com', phone: '91124-2855'
    )
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    p1 = ProductModel.create!(
      name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
      length: 22, supplier: s, product_category: pc
    )
    p2 = ProductModel.create!(
      name: 'Osso de Galinha', weight: 20, height: 4, width: 5,
      length: 5, supplier: s, product_category: pc
    )
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'
    click_on 'Edit', id: "edit_pm-#{p1.id}"
    fill_in 'Nome',	with: 'Ossos de galinha'
    fill_in 'Peso',	with: '100'
    click_on 'Save'

    # Assert
    expect(current_path).to eq product_model_path(p1.id)
    expect(page).to have_content 'Successfully edited product model'
    expect(page).to have_content 'Ossos de galinha'
    expect(page).to have_content 'Peso: 100'
  end

  it "and can't edit" do
    # Arrange
    s = Supplier.create!(
      fantasy_name: 'Maria', legal_name: 'Maria e os doces',
      cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
      email: 'maria.doceria@yahoo.com', phone: '91124-2855'
    )
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    p1 = ProductModel.create!(
      name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
      length: 22, supplier: s, product_category: pc
    )
    p2 = ProductModel.create!(
      name: 'Osso de Galinha', weight: 20, height: 4, width: 5,
      length: 5, supplier: s, product_category: pc
    )
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    login_as(user, scope: :user)
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'
    click_on 'Edit', id: "edit_pm-#{p1.id}"
    fill_in 'Nome',	with: ''
    fill_in 'Peso',	with: '0'
    click_on 'Save'

    # Assert
    expect(page).not_to have_content 'Successfully edited product model'
    expect(page).to have_content "It wasn't possible to edit the product model"
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Peso deve ser maior que 0'
  end
end
