require 'rails_helper'

describe 'Visitor view homepage' do
  it 'and see the the registred product categories' do
    # Arrange
    create(:product_category, name: "Conservados")
    create(:product_category, name: "Congelados")
    create(:product_category, name: "Industrial")
    create(:product_category, name: "Quentes")

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
