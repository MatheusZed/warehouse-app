require 'rails_helper'

describe "Register product entry", type: :request do
  it "and product model is inactive" do
    # Arrange
    supplier = create(:supplier)
    category = create(:product_category, name: "Conservados")
    warehouse = create(:warehouse, product_category_ids: [category.id])
    product_model = create(:product_model, status: 1, supplier: supplier, product_category: category)
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    headers = { 'Content-Type ' => 'application/json' }
    params = {
              product_model_id: product_model.id,
              warehouse_id: warehouse.id,
              quantity: 2
             }
    post '/product_items/entry', params: params, headers: headers

    # Assert
    expect(response.body).to include 'Este modelo de produto está inativo'
  end
end
