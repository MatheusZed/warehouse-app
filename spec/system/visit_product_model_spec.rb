require 'rails_helper'

describe 'Visitor sees the product model' do
  let(:supplier) { create(:supplier, fantasy_name: "Joao") }

  it 'and sees all registered data' do
    # Arrange
    pm = create(
      :product_model, name: "Saco de Feijao", weight: 1000, height: 4, width: 17,
      length: 22, supplier: supplier
    )

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Joao'
    click_on 'Saco de Feijao'

    # Assert
    expect(page).to have_css 'h1', text: 'Saco de Feijao'
    expect(page).to have_content 'Saco de Feijao'
    expect(page).to have_content 'Peso: 1000'
    expect(page).to have_content 'Dimensoes: 4 x 17 x 22'
    expect(page).to have_content pm.sku
    expect(page).to have_content 'Fornecedor: Joao'
  end

  it 'and can return to supplier page' do
    # Arrange
    create(:product_model, name: "Saco de Feijao", supplier: supplier)

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Joao'
    click_on 'Saco de Feijao'
    click_on 'Return'

    # Assert
    expect(current_path).to eq supplier_path(supplier.id)
  end

  it 'and sees the available warehouses' do
    # Arrange
    pc = create(:product_category)
    wh1 = create(:warehouse, code: "JRZ", product_category_ids: [pc.id])
    wh2 = create(:warehouse, code: "PLN", product_category_ids: [pc.id])
    pm1 = create(:product_model,name: "Saco de Feijao", supplier: supplier, product_category: pc)
    pm2 = create(:product_model,name: "Doces", supplier: supplier, product_category: pc)
    create_list(:product_item, 5, warehouse: wh1, product_model: pm2)
    create_list(:product_item, 4, warehouse: wh2, product_model: pm2)

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Joao'
    click_on 'Doces'

    # Assert
    expect(page).to have_content 'Available Warehouses'
    expect(page).to have_content 'Codigo do Galpao Quantidade'
    within("div#warehouse-#{wh1.id}") do
      expect(page).to have_content 'JRZ 5'
    end
    within("div#warehouse-#{wh2.id}") do
      expect(page).to have_content 'PLN 4'
    end
  end

  it 'and can active' do
    # Arrrange
    pm = create(
      :product_model, name: "Saco de Feijao", status: 1, supplier: supplier
    )

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Joao'
    click_on 'Saco de Feijao'
    click_on 'Ativar'

    # Assert
    expect(page).to have_content 'O Modelo de Produto foi ativado com sucesso!'
    expect(page).to have_css 'h1', text: 'Saco de Feijao - active'
    expect(page).to have_button 'Desativar'
  end

  it 'and can inactive' do
    # Arrrange
    pm = create(
      :product_model, name: "Saco de Feijao", supplier: supplier
    )

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Joao'
    click_on 'Saco de Feijao'
    click_on 'Desativar'

    # Assert
    expect(page).to have_content 'O Modelo de Produto foi desativado com sucesso!'
    expect(page).to have_css 'h1', text: 'Saco de Feijao - inactive'
    expect(page).to have_button 'Ativar'
  end
end
