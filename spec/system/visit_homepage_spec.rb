require 'rails_helper'

describe 'Visitor view homepage' do
  #cenario
  it 'and see a welcome message' do
    visit root_path

    expect(page).to have_content 'Welcome to the Warehouse App'
  end

  it 'and see a welcome message with h1' do
    visit root_path

    expect(page).to have_css('h1', text: 'Welcome to the Warehouse App')
  end

  it 'and see the the registred sheds' do
    # Arrange => Preparar
    Warehouse.new(name: 'Guarulhos',    code: 'GRU').save()
    Warehouse.new(name: 'Porto Alegre', code: 'POA').save()
    Warehouse.new(name: 'Sao Luiz',     code: 'SLZ').save()
    Warehouse.new(name: 'Vitoria',      code: 'VIX').save()
    
    # Act => Agir ou Executar
    visit root_path

    # Asset => Garantir ou validar ou checar
    expect(page).to have_content('Guarulhos')
    expect(page).to have_content('GRU')
    expect(page).to have_content('Porto Alegre')
    expect(page).to have_content('POA')
    expect(page).to have_content('Sao Luiz')
    expect(page).to have_content('SLZ')
    expect(page).to have_content('Vitoria')
    expect(page).to have_content('VIX')
  end
end