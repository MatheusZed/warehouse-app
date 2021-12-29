require 'rails_helper'

describe 'Visitor register warehouse' do 
  it 'throught the link in homepage' do
    #Arrange

    #Act
    visit root_path
    click_on 'Register new warehouse'

    #Assert
    expect(page).to have_content 'New Warehouse'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Codigo'
    expect(page).to have_field 'Descricao'
    expect(page).to have_field 'Endereco'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Area Total'
    expect(page).to have_field 'Area Util'
    expect(page).to have_button 'Gravar'
  end

  it 'successfully' do
    #Arrange

    #Act
    visit root_path
    click_on 'Register new warehouse'
    fill_in 'Nome', with: 'Juiz de Fora'
    fill_in 'Codigo', with: 'JDF'
    fill_in 'Descricao', with: 'Um galpao mineiro com o pé no Rio'
    fill_in 'Endereco', with: 'Av Rio Branco'
    fill_in 'Cidade', with: 'Juiz de Fora'
    fill_in 'Estado', with: 'MG'
    fill_in 'CEP', with: '36000-000'
    fill_in 'Area Total', with: '5000'
    fill_in 'Area Util', with: '3000'
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Galpao registrado com sucesso' 
    expect(page).to have_content 'Juiz de Fora'
    expect(page).to have_content 'JDF'
    expect(page).to have_content 'Descrição: Um galpao mineiro com o pé no Rio'
    expect(page).to have_content 'Endereço: Av Rio Branco-Juiz de Fora/MG'
    expect(page).to have_content 'CEP: 36000-000'
    expect(page).to have_content 'Area Total: 5000 m2'
    expect(page).to have_content 'Area Util: 3000 m2'
  end
end
