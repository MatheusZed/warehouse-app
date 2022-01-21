require 'rails_helper'

describe 'Visitor sees the product category' do
  let(:supplier) { create(:supplier, fantasy_name: "Joao") }

  it 'and sees all registered data' do
    # Arrange
    pc = create(:product_category, name: "Conservados")
    pm = create(:product_model, name: "Saco de Feijao", supplier: supplier, product_category: pc)

    # Act
    visit root_path
    click_on 'See product categories'
    click_on 'Conservados'

    # Assert
    expect(page).to have_css 'h1', text: 'Conservados'
    expect(page).to have_content 'Joao'
    expect(page).to have_content 'Saco de Feijao'
    expect(page).to have_content pm.sku
  end

  it 'and can return to product categories page' do
    # Arrange
    pc = create(:product_category, name: "Conservados")
    pm = create(:product_model, name: "Saco de Feijao", supplier: supplier, product_category: pc)

    # Act
    visit root_path
    click_on 'See product categories'
    click_on 'Conservados'
    click_on 'Return'

    # Assert
    expect(current_path).to eq product_categories_path
  end
end
