require 'rails_helper'

describe 'User registers a kit' do
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

  it 'Successfully' do
    # Arrange
    s = Supplier.create!(fantasy_name: 'Vinicola Miolo', legal_name: 'Miolo Fabrica de Bebidas LTDA',
                         cnpj: '30605809000108', address: 'Av Cabernet, 100',
                         email: 'contato@miolovinhos.com', phone: '71 91124-7753')
    ProductModel.create!(name: 'Vinho Tinto Miolo', weight: 800, height: 30,
                         width: 10, length: 10, supplier: s, sku: 'I112A')
    ProductModel.create!(name: 'Taça para vinho tinto', weight: 30, height: 12,
                         width: 10, length: 10, supplier: s, sku: 'I132A')
    ProductModel.create!(name: 'Saco de batata rustica', weight: 1500, height: 100,
                         width: 100, length: 100, supplier: s, sku: 'I182A')
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Register new product bundle'
    fill_in 'Nome',	with: 'Kit Degustacao Miolo'
    fill_in 'Codigo SKU', with: 'KI19A'
    check 'Vinho Tinto Miolo'
    check 'Taça para vinho tinto'
    click_on 'Register'

    # Assert
    expect(page).to have_content 'Kit Degustacao Miolo'
    expect(page).to have_content 'Codigo SKU: KI19A'
    expect(page).to have_content 'Vinho Tinto Miolo'
    expect(page).to have_content 'Taça para vinho tinto'
    expect(page).not_to have_content 'Saco de batata rustica'
  end
end