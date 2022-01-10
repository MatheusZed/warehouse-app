require 'rails_helper'

describe 'User edits product bundle' do
  it 'Visitor not sees the menu' do
    # Arrange
    s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e os doces',
                         cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
                         email: 'maria.doceria@yahoo.com', phone: '91124-2855')
    pc = ProductCategory.create!(name: 'Conservados')
    pm1 = ProductModel.create!(name: 'Migalhas de pao', weight: 1000, height: 4, width: 17, 
                               length: 22, supplier: s, product_category: pc)
    pm2 = ProductModel.create!(name: 'Osso de Frango', weight: 1000, height: 4, width: 17, 
                               length: 22, supplier: s, product_category: pc)
    pm3 = ProductModel.create!(name: 'Doces', weight: 1000, height: 4, width: 17, 
                               length: 22, supplier: s, product_category: pc)
    pb = ProductBundle.create!(name: 'Kit Bruxaria')
    ProductBundleItem.create!(product_bundle: pb, product_model: pm1)
    ProductBundleItem.create!(product_bundle: pb, product_model: pm2)

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'

    # Assert
    expect(page).not_to have_link 'Edit'
  end

  it "Visitor don't access the form directly" do
    # Arrange
    s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e os doces',
                         cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
                         email: 'maria.doceria@yahoo.com', phone: '91124-2855')
    pc = ProductCategory.create!(name: 'Conservados')
    pm1 = ProductModel.create!(name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pm2 = ProductModel.create!(name: 'Osso de Frango', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pm3 = ProductModel.create!(name: 'Doces', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pb = ProductBundle.create!(name: 'Kit Bruxaria')
    ProductBundleItem.create!(product_bundle: pb, product_model: pm1)
    ProductBundleItem.create!(product_bundle: pb, product_model: pm2)

    # Act
    visit edit_product_bundle_path(s.id)

    # Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'through the list screen' do
    # Arrange
    s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e os doces',
                         cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
                         email: 'maria.doceria@yahoo.com', phone: '91124-2855')
    pc = ProductCategory.create!(name: 'Conservados')
    pm1 = ProductModel.create!(name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pm2 = ProductModel.create!(name: 'Osso de Frango', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pm3 = ProductModel.create!(name: 'Doces', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pb1 = ProductBundle.create!(name: 'Kit Bruxaria')
    pb2 = ProductBundle.create!(name: 'Kit Xariabru')
    ProductBundleItem.create!(product_bundle: pb1, product_model: pm1)
    ProductBundleItem.create!(product_bundle: pb1, product_model: pm2)
    ProductBundleItem.create!(product_bundle: pb2, product_model: pm2)
    ProductBundleItem.create!(product_bundle: pb2, product_model: pm3)
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'
    click_on 'Edit', id: "edit_pb-#{pb1.id}"

    # Assert
    expect(current_path).to eq edit_product_bundle_path(pb1.id)
    expect(page).to have_content 'Edit Product Bundle'
  end

  it 'successfully' do
    # Arrange
    s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e os doces',
                         cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
                         email: 'maria.doceria@yahoo.com', phone: '91124-2855')
    pc = ProductCategory.create!(name: 'Conservados')
    pm1 = ProductModel.create!(name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pm2 = ProductModel.create!(name: 'Osso de Frango', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pm3 = ProductModel.create!(name: 'Doces', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pb1 = ProductBundle.create!(name: 'Kit Bruxaria')
    pb2 = ProductBundle.create!(name: 'Kit Xariabru')
    ProductBundleItem.create!(product_bundle: pb1, product_model: pm1)
    ProductBundleItem.create!(product_bundle: pb1, product_model: pm2)
    ProductBundleItem.create!(product_bundle: pb2, product_model: pm2)
    ProductBundleItem.create!(product_bundle: pb2, product_model: pm3)
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'
    click_on 'Edit', id: "edit_pb-#{pb1.id}"
    fill_in 'Nome',	with: 'Kit Bruxaria Personalizado'
    uncheck 'Osso de Frango'
    check 'Doces'
    click_on 'Save'

    # Assert
    expect(current_path).to eq product_bundle_path(pb1.id)
    expect(page).to have_content 'Successfully edited product bundle'
    expect(page).not_to have_content 'Ossos de galinha'
    expect(page).to have_content 'Doces'
    expect(page).to have_content 'Kit Bruxaria Personalizado'
  end

  it "and can't edit" do
    # Arrange
    s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e os doces',
                         cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
                         email: 'maria.doceria@yahoo.com', phone: '91124-2855')
    pc = ProductCategory.create!(name: 'Conservados')
    pm1 = ProductModel.create!(name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pm2 = ProductModel.create!(name: 'Osso de Frango', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pm3 = ProductModel.create!(name: 'Doces', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pb1 = ProductBundle.create!(name: 'Kit Bruxaria', sku: 'KI16A')
    pb2 = ProductBundle.create!(name: 'Kit Xariabru', sku: 'KI17A')
    ProductBundleItem.create!(product_bundle: pb1, product_model: pm1)
    ProductBundleItem.create!(product_bundle: pb1, product_model: pm2)
    ProductBundleItem.create!(product_bundle: pb2, product_model: pm2)
    ProductBundleItem.create!(product_bundle: pb2, product_model: pm3)
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'
    click_on 'Edit', id: "edit_pb-#{pb1.id}"
    fill_in 'Nome',	with: '' 
    click_on 'Save'

    # Assert
    expect(page).not_to have_content 'Successfully edited product bundle'
    expect(page).to have_content "It wasn't possible to edit the product bundle"
    expect(page).to have_content 'Nome não pode ficar em branco'
  end
end
