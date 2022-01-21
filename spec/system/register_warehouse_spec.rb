require 'rails_helper'

describe 'User register warehouse' do
  it 'Visitor not sees the menu' do
    # Act
    visit root_path

    # Assert
    expect(page).not_to have_link 'Register new warehouse'
  end

  it "Visitor don't access the form directly" do
    # Act
    visit new_warehouse_path

    # Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'throught the link in homepage' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new warehouse'

    # Assert
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
    expect(page).to have_content 'Categorias de produto'
    expect(page).to have_button 'Save'
  end

  it 'successfully' do
    # Arrange
    create(:product_category, name: "Conservados")
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
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
    check 'Conservados'
    click_on 'Save'

    # Assert
    expect(page).to have_content 'Successfully registered warehouse'
    expect(page).to have_content 'Juiz de Fora'
    expect(page).to have_content 'JDF'
    expect(page).to have_content 'Descrição: Um galpao mineiro com o pé no Rio'
    expect(page).to have_content 'Endereço: Av Rio Branco-Juiz de Fora/MG'
    expect(page).to have_content 'CEP: 36000-000'
    expect(page).to have_content 'Area Total: 5000 m2'
    expect(page).to have_content 'Area Util: 3000 m2'
    expect(page).to have_content 'Categorias aceitas no galpao'
    expect(page).to have_content 'Conservados'
  end

  it 'and all fields are required' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new warehouse'
    fill_in 'Nome', with: ''
    fill_in 'Codigo', with: ''
    fill_in 'Endereco', with: ''
    click_on 'Save'

    # Assert
    expect(page).not_to have_content 'Successfully registered warehouse'
    expect(page).to have_content "It wasn't possible to record the warehouse"
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Codigo não pode ficar em branco'
    expect(page).to have_content 'Descricao não pode ficar em branco'
    expect(page).to have_content 'Endereco não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'CEP não pode ficar em branco'
    expect(page).to have_content 'Area Total não pode ficar em branco'
    expect(page).to have_content 'Area Util não pode ficar em branco'
    expect(page).to have_content 'Categorias de Produto : é necessario selecionar no minimo 1'
  end
end
