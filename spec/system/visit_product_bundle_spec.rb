require 'rails_helper'

describe 'Visitor sees the product model' do
  let(:supplier) { create(:supplier, fantasy_name: "Maria") }
  
  it 'and sees all registered data' do
    # Arrange
    pm1 = create(:product_model, name: "Migalhas de pao", supplier: supplier)
    pm2 = create(:product_model, name: "Osso de Frango", supplier: supplier)
    pm3 = create(:product_model, name: "Docerias", supplier: supplier)
    pb1 = create(:product_bundle, name: "Kit Bruxaria", product_model_ids: [pm1.id, pm2.id, pm3.id])
    pb2 = create(:product_bundle, name: "Kit Xariabru", product_model_ids: [pm1.id, pm3.id])

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'
    click_on 'Kit Bruxaria'

    # Assert
    expect(page).to have_css 'h1', text: 'Kit Bruxaria'
    expect(page).to have_content "Codigo SKU: #{pb1.sku}"
    expect(page).to have_content 'Migalhas de pao'
    expect(page).to have_content 'Osso de Frango'
    expect(page).to have_content 'Docerias'
  end

  it 'and can return to supplier page' do
    # Arrange
    pm1 = create(:product_model, supplier: supplier)
    pm2 = create(:product_model, supplier: supplier)
    pm3 = create(:product_model, supplier: supplier)
    pb1 = create(:product_bundle, name: "Kit Bruxaria", product_model_ids: [pm1.id, pm2.id, pm3.id])
    pb2 = create(:product_bundle, name: "Kit Xariabru", product_model_ids: [pm1.id, pm3.id])

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'
    click_on 'Kit Xariabru'
    click_on 'Return'

    # Assert
    expect(current_path).to eq supplier_path(supplier.id)
  end
end
