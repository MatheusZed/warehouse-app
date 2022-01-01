require 'rails_helper'

describe 'Visitor sees the supplier' do
  it 'and sees all registered data' do
    # Arrange
    Supplier.create(fantasy_name: 'Joao', legal_name: 'Joao e os doces', 
                    cnpj: '22416076000135', address: 'Rua Benedito Spinardi', 
                    email: 'joao.doceria@yahoo.com', phone: '91124-2854')

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Joao'

    # Assert
    expect(page).to have_content 'Joao'
    expect(page).to have_content 'Joao e os doces'
    expect(page).to have_content 'CNPJ: 22416076000135'
    expect(page).to have_content 'Endereço: Rua Benedito Spinardi'
    expect(page).to have_content 'Email: joao.doceria@yahoo.com'
    expect(page).to have_content 'Telefone: 91124-2854'    
  end

  it 'and can return to suppliers page' do
    # Arrange
    Supplier.create(fantasy_name: 'Joao', legal_name: 'Joao e os doces', 
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
end