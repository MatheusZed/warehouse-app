require 'rails_helper'

describe 'Visitor sees the supplier' do
  it 'and sees all registered data' do
    # Arrange
    s = create(
      :supplier, fantasy_name: "Joao", legal_name: "Joao e os doces",
      cnpj: "22416076000135", address: "Rua Benedito Spinardi",
      email: "joao.doceria@yahoo.com", phone: "91124-2854"
    )

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
    create(:supplier, fantasy_name: "Joao")

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Joao'
    click_on 'Return'

    # Assert
    expect(current_path).to eq suppliers_path
  end
end
