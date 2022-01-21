require 'rails_helper'

describe 'Visitor view homepage' do
  let(:pc) { create(:product_category) }

  it 'and see a welcome message' do
    visit root_path

    expect(page).to have_content 'Welcome to the Warehouse App'
  end

  it 'and see a welcome message with h1' do
    visit root_path

    expect(page).to have_css 'h3', text: 'Welcome to the Warehouse App'
  end

  it 'and see the the registred warehouse' do
    # Arrange => Preparar o banco
    create(:warehouse, name: "Guarulhos", code: "GRU", product_category_ids: [pc.id])
    create(:warehouse, name: "Porto Alegre", code: "POA", product_category_ids: [pc.id])
    create(:warehouse, name: "Sao Luiz", code: "SLZ", product_category_ids: [pc.id])
    create(:warehouse, name: "Vitoria", code: "VIX", product_category_ids: [pc.id])

    # Act => Agir ou Executar
    visit root_path

    # Assert => Garantir ou validar ou checar / esperar que algo acontessa
    expect(page).to have_content 'Guarulhos'
    expect(page).to have_content 'GRU'
    expect(page).to have_content 'Porto Alegre'
    expect(page).to have_content 'POA'
    expect(page).to have_content 'Sao Luiz'
    expect(page).to have_content 'SLZ'
    expect(page).to have_content 'Vitoria'
    expect(page).to have_content 'VIX'
  end

  it "and don't see the warehouse details" do
    # Arrange
    create(
      :warehouse, name: "Alimenticio", code: "ALM", description: "Otimo galpao com luzes",
      address: "Av Fernandes Lima", city: "Maceio", state: "AL", postal_code: "57050-000",
      total_area: 10_000, useful_area: 8000, product_category_ids: [pc.id]
    )

    # Act
    visit root_path

    # Assert
    expect(page).not_to have_content 'Otimo galpao numa linda cidade'
    expect(page).not_to have_content 'Av Fernandes Lima'
    expect(page).not_to have_content 'Maceio/AL'
    expect(page).not_to have_content 'CEP: 57050-000'
    expect(page).not_to have_content 'Area Total: 10000 m2'
    expect(page).not_to have_content 'Area Util: 8000 m2'
    expect(page).not_to have_content 'Categorias aceitas no galpao'
    expect(page).not_to have_content 'Conservados'
  end

  it "and doesn't exist any warehouse" do
    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'No registered warehouse'
  end
end
