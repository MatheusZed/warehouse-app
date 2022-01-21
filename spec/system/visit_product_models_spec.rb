require 'rails_helper'

describe 'Visitor see product models' do
  let(:supplier) { create(:supplier, fantasy_name: "Maria") }

  it 'and sees the resgistered product models' do
    # Arrange
    pm1 = create(:product_model, name: "Migalhas de pao", supplier: supplier)
    pm2 = create(:product_model, name: "Osso de Frango", supplier: supplier)
    pm3 = create(:product_model, name: "Doces", supplier: supplier)

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'

    # Assert
    expect(page).to have_css '#pm h2', text: 'Product models from this supplier'
    expect(page).to have_css '#pmi', text: 'Migalhas de pao'
    expect(page).to have_css '#pmi', text: pm1.sku
    expect(page).to have_css '#pmi', text: 'Osso de Frango'
    expect(page).to have_css '#pmi', text: pm2.sku
    expect(page).to have_css '#pmi', text: 'Doces'
    expect(page).to have_css '#pmi', text: pm3.sku
  end

  it "and don't sees the product models details" do
    # Arrange
    create(
      :product_model, name: "Migalhas de pao", weight: 1000,
      height: 10, width: 5, length: 22, supplier: supplier
    )
    create(
      :product_model, name: "Ossos de Frango", weight: 5,
      height: 15, width: 2, length: 2, supplier: supplier
    )
    create(
      :product_model, name: "Doces", weight: 1100, height: 100,
      width: 100, length: 100, supplier: supplier
    )

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'

    # Assert
    expect(page).not_to have_css '#pm dd', text: 'Maria'
    expect(page).not_to have_css '#pmi', text: 'Peso: 1000'
    expect(page).not_to have_css '#pmi', text: 'Dimensoes: 10 x 5 x 22'
    expect(page).not_to have_css '#pmi', text: 'Peso: 5'
    expect(page).not_to have_css '#pmi', text: 'Dimensoes: 15 x 2 x 2'
    expect(page).not_to have_css '#pmi', text: 'Peso: 1100'
    expect(page).not_to have_css '#pmi', text: 'Dimensoes: 100 x 100 x 100'
  end

  it "and don't sees other supplier product models" do
    # Arrange
    supplier2 = create(:supplier, fantasy_name: "Joao")
    pm1 = create(:product_model, name: "Migalhas de pao", supplier: supplier)
    pm2 = create(:product_model, name: "Osso de Frango", supplier: supplier)
    pm3 = create(:product_model, name: "Doces", supplier: supplier2)
    pm4 = create(:product_model, name: "Casinha de Doces", supplier: supplier2)

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Joao'

    # Assert
    expect(page).to have_css '#pmi', text: 'Doces'
    expect(page).to have_css '#pmi', text: pm3.sku
    expect(page).to have_css '#pmi', text: 'Casinha de Doces'
    expect(page).to have_css '#pmi', text: pm4.sku
    expect(page).not_to have_css '#pmi', text: 'Migalhas de pao'
    expect(page).not_to have_css '#pmi', text: pm1.sku
    expect(page).not_to have_css '#pmi', text: 'Osso de Frango'
    expect(page).not_to have_css '#pmi', text: pm2.sku
  end

  it "and doesn't exist any product model" do
    # Arrange
    supplier

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'

    # Assert
    expect(page).to have_css '#pm', text: 'No registered product model'
  end
end
