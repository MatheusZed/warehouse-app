require 'rails_helper'

describe 'Visitor view homepage' do
  it 'and see the the registred product categories' do
    # Arrange
    ProductCategory.create!(name: 'Conservados')
    ProductCategory.create!(name: 'Congelados')
    ProductCategory.create!(name: 'Industrial')
    ProductCategory.create!(name: 'Quentes')

    # Act
    visit root_path
    click_on 'See product categories'

    # Assert
    expect(page).to have_content 'Conservados'
    expect(page).to have_content 'Congelados'
    expect(page).to have_content 'Industrial'
    expect(page).to have_content 'Quentes'
  end

  it "and doesn't exist any product category" do
    # Act
    visit root_path
    click_on 'See product categories'

    # Assert
    expect(page).to have_content 'No registered product category'
  end
end
