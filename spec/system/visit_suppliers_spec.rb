require 'rails_helper'

describe 'Visitor see suppliers' do
  it 'and sees the resgistered suppliers' do
    # Arrange
    Supplier.create!(
      fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
      cnpj: '30605809000108', address: 'Av Fernandes Lima',
      email: 'joao.feijao@yahoo.com', phone: '91124-7753')
    Supplier.create!(
      fantasy_name: 'Maria', legal_name: 'Maria e o pao',
      cnpj: '59201134000113', address: 'Av Fernandes China',
      email: 'maria.pao@yahoo.com', phone: '91124-7799'
    )

    # Act
    visit root_path
    click_on 'See suppliers'

    # Assert
    expect(page).to have_css 'h1', text: 'Registered suppliers'
    expect(page).to have_content 'Joao'
    expect(page).to have_content '30605809000108'
    expect(page).to have_content 'Maria'
    expect(page).to have_content '59201134000113'
  end

  it "and don't sees the suppliers details" do
    # Arrange
    Supplier.create!(
      fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
      cnpj: '30605809000108', address: 'Av Fernandes Lima',
      email: 'joao.feijao@yahoo.com', phone: '91124-7753'
    )
    Supplier.create!(
      fantasy_name: 'Maria', legal_name: 'Maria e o pao',
      cnpj: '59201134000113', address: 'Av Fernandes China',
      email: 'maria.pao@yahoo.com', phone: '91124-7799'
    )

    # Act
    visit root_path
    click_on 'See suppliers'

    # Assert
    expect(page).not_to have_content 'Joao pe de feijao'
    expect(page).not_to have_content 'Av Fernandes Lima'
    expect(page).not_to have_content 'joao.feijao@yahoo.com'
    expect(page).not_to have_content '91124-7753'
    expect(page).not_to have_content 'Maria e o pao'
    expect(page).not_to have_content 'Av Fernandes China'
    expect(page).not_to have_content 'maria.pao@yahoo.com'
    expect(page).not_to have_content '91124-7799'
  end

  it "and doesn't exist any supplier" do
    # Act
    visit root_path
    click_on 'See suppliers'

    # Assert
    expect(page).to have_content 'No registered supplier'
  end
end
