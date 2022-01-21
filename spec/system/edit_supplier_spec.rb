require 'rails_helper'

describe 'User edits supplier' do
  it 'Visitor not sees the menu' do
    # Arrange
    create(:supplier)

    # Act
    visit root_path
    click_on 'See suppliers'

    # Assert
    expect(page).not_to have_link 'Edit'
  end

  it "Visitor don't access the form directly" do
    # Arrange
    s = create(:supplier)

    # Act
    visit edit_supplier_path(s.id)

    # Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'through the list screen' do
    # Arrange
    s1 = create(:supplier)
    s2 = create(:supplier)
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'See suppliers'
    click_on 'Edit', id: "edit-#{s2.id}"

    # Assert
    expect(current_path).to eq edit_supplier_path(s2.id)
    expect(page).to have_content 'Edit Supplier'
  end

  it 'successfully' do
    # Arrange
    s1 = create(:supplier)
    s2 = create(:supplier)
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'See suppliers'
    click_on 'Edit', id: "edit-#{s1.id}"
    fill_in 'Endereco',	with: 'Rua das Bruxas'
    click_on 'Save'

    # Assert
    expect(current_path).to eq supplier_path(s1.id)
    expect(page).to have_content 'Successfully edited supplier'
    expect(page).to have_content 'Endereço: Rua das Bruxas'
  end

  it "and can't edit" do
    # Arrange
    s1 = create(:supplier)
    s2 = create(:supplier)
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'See suppliers'
    click_on 'Edit', id: "edit-#{s1.id}"
    fill_in 'CNPJ',	with: '224160760001356'
    click_on 'Save'

    # Assert
    expect(page).not_to have_content 'Successfully edited supplier'
    expect(page).to have_content "It wasn't possible to edit the supplier"
    expect(page).to have_content 'CNPJ não é valido, precisa conter 14 digitos'
  end
end
