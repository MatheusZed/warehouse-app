require 'rails_helper'

describe 'user logs in' do
  it 'successfully' do
    #Arrange
    User.create!(email: 'joao@email.com', password: 'admino')

    #Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email',	with: 'joao@email.com'
    fill_in 'Senha',	with: 'admino'
    click_on 'Entrar' 

    #Assert
    expect(current_path).to eq root_path
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_link 'Sair'
    expect(page).to have_content 'Ola joao@email.com'
  end
end