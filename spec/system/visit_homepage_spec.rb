require 'rails_helper'

describe 'Visitor view homepage' do

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
    Warehouse.create!(
      name: 'Guarulhos', code: 'GRU', description: 'Aeroporto',
      address: 'Av Guarulhos', city: 'Sao Paulo', state: 'SP',
      postal_code:'55000-000', total_area: 10000, useful_area: 8000
    )
    Warehouse.create!(
      name: 'Porto Alegre', code: 'POA', description: 'Lugar bonito',
      address: 'Av Porto Alegre', city: 'Porto Alegre', state: 'RS',
      postal_code:'55000-000', total_area: 10000, useful_area: 8000
    )
    Warehouse.create!(
      name: 'Sao Luiz', code: 'SLZ', description: 'Nao Sei',
      address: 'Av Sao Luiz', city: 'Sao Luiz', state: 'MA',
      postal_code:'55000-000', total_area: 10000, useful_area: 8000
    )
    Warehouse.create!(
      name: 'Vitoria', code: 'VIX', description: 'Codigo legal',
      address: 'Av Vitoria', city: 'Vitoria', state: 'ES',
      postal_code:'55000-000', total_area: 10000, useful_area: 8000
    )

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
    Warehouse.create!(
      name: 'Alimenticio', code: 'ALM', description: 'Otimo galpao numa linda cidade',
      address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
      postal_code:'57050-000', total_area: 10000, useful_area: 8000
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
  end

  it "and doesn't exist any warehouse" do
    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'No registered warehouse'
  end
end
