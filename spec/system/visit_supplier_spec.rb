require 'rails_helper'

describe 'Visitor sees the supplier' do
  it 'and sees all registered data' do
    # Arrange
    s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao e os doces', 
                         cnpj: '22416076000135', address: 'Rua Benedito Spinardi', 
                         email: 'joao.doceria@yahoo.com', phone: '91124-2854')

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Joao'

    # Assert
    expect(page).to have_content s.fantasy_name
    expect(page).to have_content s.legal_name
    expect(page).to have_content "CNPJ: #{s.cnpj}"
    expect(page).to have_content "Endereço: #{s.address}"
    expect(page).to have_content "Email: #{s.email}"
    expect(page).to have_content "Telefone: #{s.phone}"    
  end

  it 'and can return to suppliers page' do
    # Arrange
    Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao e os doces', 
                     cnpj: '22416076000135', address: 'Rua Benedito Spinardi', 
                     email: 'joao.doceria@yahoo.com', phone: '91124-2854')

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Joao'
    click_on 'Return'

    # Assert
    expect(current_path).to eq suppliers_path
  end

  it "and see the supplier's products" do
    # Arrange
    s = Supplier.create!(fantasy_name: 'Fabrica Geek', legal_name: 'Geek Comercio de Presentes LTDA',
                         cnpj: '15462315649875', address: 'Av. Spider Man 3', phone: '31 3456-7890',
                         email: 'geekceramicas@spider.com')
    ProductModel.create!(name: 'Caneca Star Wars', height: 14, width: 10, length: 8,
                         weight: 300, sku: 'I30A', supplier: s)
    ProductModel.create!(name: 'Pelucia Dumbo', height: 50, width: 40, length: 20,
                         weight: 400, sku: 'I31A', supplier: s)

    #Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Fabrica Geek'

    #Assert
    expect(page).to have_css 'h1', text: 'Fabrica Geek'
    expect(page).to have_css 'h2', text: 'Products from this supplier'
    expect(page).to have_content 'Caneca Star Wars'
    expect(page).to have_content 'I30A'
    expect(page).to have_content 'Pelucia Dumbo'
    expect(page).to have_content 'I31A'
  end
end
