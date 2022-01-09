require 'rails_helper'

describe 'User registers a category' do
  it 'Visitor not sees the menu' do
    # Act
    visit root_path

    # Assert
    expect(page).not_to have_link 'Register new product category'
  end

  it "Visitor don't access the form directly" do
    # Act
    visit new_product_category_path

    # Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'throught the link in homepage' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    #Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Register new product category'

    # Assert
    expect(page).to have_content 'New Product Category'
    expect(page).to have_field 'Nome'
    expect(page).to have_button 'Save'
  end

  it 'Successfully' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Register new product category'
    fill_in 'Nome',	with: 'Congelados'
    click_on 'Save'

    # Assert
    expect(page).to have_content 'Successfully registered product category'
    expect(page).to have_content 'Congelados'
  end

  it 'and the field name is required' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Register new product category'
    fill_in 'Nome',	with: ''
    click_on 'Save'

    # Assert
    expect(page).not_to have_content 'Successfully registered product category'
    expect(page).to have_content "It wasn't possible to record the product category"
    expect(page).to have_content 'Nome não pode ficar em branco'
  end
end
