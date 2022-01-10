require 'rails_helper'

describe 'User enter new items' do
  it 'Successfully' do
    # Arrange
    wh1 = Warehouse.create!(name: 'Alimenticio', code: 'ALM', description: 'Otimo galpao numa linda cidade',
                            address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                            postal_code:'57050-000', total_area: 10000, useful_area: 8000)
    s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e o pao',
                         cnpj: '59201134000113', address: 'Av Fernandes China',
                         email: 'maria.pao@yahoo.com', phone: '91124-7799')
    pc = ProductCategory.create!(name: 'Conservados')
    pm1 = ProductModel.create!(name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pm2 = ProductModel.create!(name: 'Osso de Frango', weight: 5, height: 15, width: 2,
                               length: 2, supplier: s, product_category: pc)
    pm3 = ProductModel.create!(name: 'Doces', weight: 1100, height: 100, width: 100,
                               length: 100, supplier: s, product_category: pc)
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
    expect(current_path).to eq warehouse_path(wh1.id)
    expect(page).to have_css('h2', text: 'Estoque')
    within("div#product-#{pm3.id}") do
      expect(page).to have_content('Doces')
      expect(page).to have_content('Quantidade: 100')
    end 
  end
end