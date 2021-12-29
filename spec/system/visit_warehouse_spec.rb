require 'rails_helper'

describe 'Visitor sees the warehouse' do
  it 'and see all registered data' do
    # Arrange
    Warehouse.create(name: 'Alimenticio', code: 'ALM', description: 'Otimo galpao numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                     postal_code:'57050-000', total_area: 10000, useful_area: 8000)

    # Act
    visit root_path
    click_on 'Alimenticio'

    # Assert
    expect(page).to have_content 'Alimenticio'
    expect(page).to have_content 'ALM'
    expect(page).to have_content 'Descrição: Otimo galpao numa linda cidade'
    expect(page).to have_content 'Endereço: Av Fernandes Lima-Maceio/AL'
    expect(page).to have_content 'CEP: 57050-000'
    expect(page).to have_content 'Area Total: 10000 m2'
    expect(page).to have_content 'Area Util: 8000 m2'
  end

  it 'and can return to home page' do 
    # Arrange
    Warehouse.create(name: 'Alimenticio', code: 'ALM', description: 'Otimo galpao numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                     postal_code:'57050-000', total_area: 10000, useful_area: 8000)

    # Act
    visit root_path
    click_on 'Alimenticio'
    click_on 'Return'

    # Assert
    expect(current_path).to eq root_path
  end
end
