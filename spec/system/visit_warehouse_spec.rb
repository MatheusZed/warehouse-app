require 'rails_helper'

describe 'Visitor sees the warehouse' do
  let(:pc) { create(:product_category, name: "Conservados") }

  it 'and sees all registered data' do
    # Arrange
    create(
      :warehouse, name: "Osasco", code: "OZS", description: "Otimo galpao numa linda cidade",
      address: "Av Fernandes Lima", city: "Maceio", state: "AL", postal_code: "57050-000",
      total_area: 10_000, useful_area: 8000, product_category_ids: [pc.id]
    )

    # Act
    visit root_path
    click_on 'Osasco'

    # Assert
    expect(page).to have_content 'Osasco'
    expect(page).to have_content 'OZS'
    expect(page).to have_content 'Descrição: Otimo galpao numa linda cidade'
    expect(page).to have_content 'Endereço: Av Fernandes Lima-Maceio/AL'
    expect(page).to have_content 'CEP: 57050-000'
    expect(page).to have_content 'Area Total: 10000 m2'
    expect(page).to have_content 'Area Util: 8000 m2'
    expect(page).to have_content 'Categorias aceitas no galpao'
    expect(page).to have_content 'Conservados'
  end

  it 'and can return to home page' do
    # Arrange
    create(:warehouse, name: "Osasco", product_category_ids: [pc.id])

    # Act
    visit root_path
    click_on 'Osasco'
    click_on 'Return'

    # Assert
    expect(current_path).to eq root_path
  end
end
