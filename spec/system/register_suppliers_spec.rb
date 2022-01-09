require 'rails_helper'

describe 'User register suppliers' do
  it 'Visitor not sees the menu' do
    # Act
    visit root_path

    # Assert
    expect(page).not_to have_link 'Register new supplier'
  end

  it "Visitor don't access the form directly" do
    # Act
    visit new_supplier_path

    # Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'throught the link in homepage' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    #Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new supplier'

    # Assert
    expect(page).to have_content 'New Supplier'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'Razao Social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereco'
    expect(page).to have_field 'Email'
    expect(page).to have_field 'Telefone'
    expect(page).to have_button 'Save'
  end

  it 'successfully' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    #Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new supplier'
    fill_in 'Nome Fantasia', with: 'Cleber'
    fill_in 'Razao Social', with: 'Cleber Britadeiras'
    fill_in 'CNPJ',  with: '06952413000152'
    fill_in 'Endereco', with: 'Av Rio Branco'
    fill_in 'Email', with: 'cleberbritadeiras@gmail.com'
    fill_in 'Telefone', with: '99991-4488'
    click_on 'Save'
    
    # Assert
    expect(page).to have_content 'Successfully registered supplier' 
    expect(page).to have_content 'Cleber'
    expect(page).to have_content 'Cleber Britadeiras'
    expect(page).to have_content 'CNPJ: 06952413000152'
    expect(page).to have_content 'Endereço: Av Rio Branco'
    expect(page).to have_content 'Email: cleberbritadeiras@gmail.com'
    expect(page).to have_content 'Telefone: 99991-4488'
  end

  it 'and some fields are required' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    #Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new supplier'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razao Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Email', with: ''
    click_on 'Save'

    # Assert
    expect(page).not_to have_content 'Successfully registered supplier'
    expect(page).to have_content "It wasn't possible to record the supplier"
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Razao Social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Email não pode ficar em branco'
  end

  it 'and the cnpj must be 14 digits long' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    #Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new supplier'
    fill_in 'CNPJ', with: '1154478894521'
    click_on 'Save'

    # Assert
    expect(page).to have_content 'CNPJ não é valido, precisa conter 14 digitos'
  end
end
