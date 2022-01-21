require 'rails_helper'

describe 'Visitor see product bundles' do
  let!(:supplier) { create(:supplier, fantasy_name: "Maria") }

  it 'and sees the resgistered product bundles' do
    # Arrange
    pm1 = create(:product_model, supplier: supplier)
    pm2 = create(:product_model, supplier: supplier)
    pm3 = create(:product_model, supplier: supplier)
    pb1 = create(:product_bundle, name: "Kit Bruxaria", product_model_ids: [pm1.id, pm2.id])
    pb2 = create(:product_bundle, name: "Kit Xariabru", product_model_ids: [pm1.id, pm3.id])

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'

    # Assert
    expect(page).to have_css '#pb h2', text: 'Bundles from this supplier'
    expect(page).to have_css '#pbi', text: 'Kit Bruxaria'
    expect(page).to have_css '#pbi', text: pb1.sku
    expect(page).to have_css '#pbi', text: 'Kit Xariabru'
    expect(page).to have_css '#pbi', text: pb2.sku
  end

  it "and don't sees the product bundles details" do
    # Arrange
    pm1 = create(:product_model, name: "Migalhas de pao", supplier: supplier)
    pm2 = create(:product_model, name: "Osso de Frango", supplier: supplier)
    pm3 = create(:product_model, name: "Doces", supplier: supplier)
    pb1 = create(:product_bundle, name: "Kit Bruxaria", product_model_ids: [pm1.id, pm2.id, pm3.id])
    pb2 = create(:product_bundle, name: "Kit Xariabru", product_model_ids: [pm1.id, pm3.id])

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'

    # Assert
    expect(page).not_to have_css '#pb td', text: 'Maria'
    expect(page).not_to have_css '#pbi', text: 'Migalhas de pao'
    expect(page).not_to have_css '#pbi', text: 'Osso de Frango'
    expect(page).not_to have_css '#pbi', text: 'Doces'
  end

  it "and don't sees other supplier product bundles" do
    # Arrange
    supplier2 = create(:supplier, fantasy_name: "Joao")
    pm1 = create(:product_model, supplier: supplier)
    pm2 = create(:product_model, supplier: supplier)
    pm3 = create(:product_model, supplier: supplier)
    pm4 = create(:product_model, supplier: supplier2)
    pm5 = create(:product_model, supplier: supplier2)
    pm6 = create(:product_model, supplier: supplier2)
    pb1 = create(:product_bundle, name: "Kit Bruxaria", product_model_ids: [pm1.id, pm2.id])
    pb2 = create(:product_bundle, name: "Kit Xariabru", product_model_ids: [pm1.id, pm3.id])
    pb3 = create(:product_bundle, name: "Kit Xabruria", product_model_ids: [pm4.id, pm5.id])
    pb4 = create(:product_bundle, name: "Kit Riabruxa", product_model_ids: [pm4.id, pm6.id])

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Joao'

    # Assert
    expect(page).to have_css '#pbi', text: 'Xabruria'
    expect(page).to have_css '#pbi', text: pb3.sku
    expect(page).to have_css '#pbi', text: 'Riabruxa'
    expect(page).to have_css '#pbi', text: pb4.sku
    expect(page).not_to have_css '#pbi', text: 'Bruxaria'
    expect(page).not_to have_css '#pbi', text: pb1.sku
    expect(page).not_to have_css '#pbi', text: 'Xariabru'
    expect(page).not_to have_css '#pbi', text: pb2.sku
  end

  it "and doesn't exist any product bundle" do
    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'

    # Assert
    expect(page).to have_css '#pb', text: 'No registered product bundle'
  end
end
