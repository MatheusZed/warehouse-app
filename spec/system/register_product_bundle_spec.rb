require 'rails_helper'

describe 'User registers a bundle' do
  it 'Visitor not sees the menu' do
    # Act
    visit root_path

    # Assert
    expect(page).not_to have_link 'Register new product bundle'
  end

  it "Visitor don't access the form directly" do
    # Act
    visit new_product_bundle_path

    # Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'throught the link in homepage' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    #Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new product bundle'

    # Assert
    expect(page).to have_content 'New Product Bundle'
    expect(page).to have_field 'Nome'
    expect(page).to have_button 'Save'
  end

  it 'Successfully' do
    # Arrange
    s = Supplier.create!(
      fantasy_name: 'Vinicola Miolo', legal_name: 'Miolo Fabrica de Bebidas LTDA',
      cnpj: '30605809000108', address: 'Av Cabernet, 100',
      email: 'contato@miolovinhos.com', phone: '71 91124-7753'
    )
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    ProductModel.create!(
      name: 'Vinho Tinto Miolo', weight: 800, height: 30, width: 10,
      length: 10, supplier: s, product_category: pc
    )
    ProductModel.create!(
      name: 'Taça para vinho tinto', weight: 30, height: 12, width: 10,
      length: 10, supplier: s, product_category: pc
    )
    ProductModel.create!(
      name: 'Saco de batata rustica', weight: 1500, height: 100, width: 100,
      length: 100, supplier: s, product_category: pc
    )
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new product bundle'
    fill_in 'Nome',	with: 'Kit Degustacao Miolo'
    check 'Vinho Tinto Miolo'
    check 'Taça para vinho tinto'
    click_on 'Save'

    # Assert
    pb = ProductBundle.last
    expect(page).to have_content 'Successfully registered product bundle'
    expect(page).to have_content 'Kit Degustacao Miolo'
    expect(page).to have_content "Codigo SKU: #{pb.sku}"
    expect(page).to have_content 'Vinho Tinto Miolo'
    expect(page).to have_content 'Taça para vinho tinto'
    expect(page).not_to have_content 'Saco de batata rustica'
  end

  it 'and the fields are required' do
    # Arrange
    s = Supplier.create!(
      fantasy_name: 'Maria', legal_name: 'Maria e os doces',
      cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
      email: 'maria.doceria@yahoo.com', phone: '91124-2855'
    )
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    pm1 = ProductModel.create!(
      name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
      length: 22, supplier: s, product_category: pc
    )
    pm2 = ProductModel.create!(
      name: 'Osso de Frango', weight: 1000, height: 4, width: 17,
      length: 22, supplier: s, product_category: pc
    )
    pm3 = ProductModel.create!(
      name: 'Doces', weight: 1000, height: 4, width: 17,
      length: 22, supplier: s, product_category: pc
    )
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new product bundle'
    fill_in 'Nome',	with: ''
    check 'Migalhas de pao'
    click_on 'Save'

    # Assert
    expect(page).not_to have_content 'Successfully registered product bundle'
    expect(page).to have_content "It wasn't possible to record the product bundle"
    expect(page).to have_content 'Nome não pode ficar em branco'
  end

  pending "and the supplier can't see the other supplier's product model" do
    # Arrange
    s1 = Supplier.create!(
      fantasy_name: 'Vinicola Miolo', legal_name: 'Miolo Fabrica de Bebidas LTDA',
      cnpj: '30605809000108', address: 'Av Cabernet, 100',
      email: 'contato@miolovinhos.com', phone: '71 91124-7753'
    )
    s2 = Supplier.create!(
      fantasy_name: 'Toys', legal_name: 'Fabrica de Brinquedos LTDA',
      cnpj: '30605809580108', address: 'Av Cabernet, 200',
      email: 'contato@toys.com', phone: '71 92924-7853'
    )
    pc1 = ProductCategory.create!(
      name: 'Destilados'
    )
    pc2 = ProductCategory.create!(
      name: 'Action Figure'
    )
    ProductModel.create!(
      name: 'Vinho Tinto Miolo', weight: 800, height: 30, width: 10,
      length: 10, supplier: s1, product_category: pc1
    )
    ProductModel.create!(
      name: 'Taça para vinho tinto', weight: 30, height: 12, width: 10,
      length: 10, supplier: s1, product_category: pc1
    )
    ProductModel.create!(
      name: 'Vinho Rose', weight: 1000, height: 100, width: 100,
      length: 100, supplier: s1, product_category: pc1
    )
    ProductModel.create!(
      name: 'Boneco do Batman', weight: 500, height: 100, width: 100,
      length: 100, supplier: s2, product_category: pc2
    )
    ProductModel.create!(
      name: 'Boneco do Homem-Aranha', weight: 500, height: 100, width: 100,
      length: 100, supplier: s2, product_category: pc2
    )
    ProductModel.create!(
      name: 'Boneco do Mutano', weight: 500, height: 100, width: 100,
      length: 100, supplier: s2, product_category: pc2
    )
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new product bundle'
    select 'Toys', from: 'Fornecedor'

    # Assert
    expect(page).to have_content 'Boneco do Batman'
    expect(page).to have_content 'Boneco do Homem-Aranha'
    expect(page).to have_content 'Boneco do Mutano'
    expect(page).not_to have_content 'Vinho Tinto Miolo'
    expect(page).not_to have_content 'Taça para vinho tinto'
    expect(page).not_to have_content 'Vinho Rose'
  end  
end
