require 'rails_helper'

describe 'user logs in' do
  it 'successfully' do
    # Arrange
    User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail',	with: 'joao@email.com'
      fill_in 'Senha',	with: 'admino'
      click_on 'Entrar'
    end

    # Assert
    expect(current_path).to eq root_path
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_link 'Sair'
    expect(page).to have_content 'Ola joao@email.com'
    expect(page).to have_content 'Login efetuado com sucesso'
  end

  it 'and does logout' do
    # Arrange
    User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail',	with: 'joao@email.com'
      fill_in 'Senha',	with: 'admino'
      click_on 'Entrar'
    end
    click_on 'Sair'

    # Assert
    expect(current_path).to eq root_path
    expect(page).not_to have_link 'Sair'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_content 'Ola joao@email.com'
    expect(page).to have_content 'Logout efetuado com sucesso'
  end
end
