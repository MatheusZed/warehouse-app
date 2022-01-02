require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  it '.dimension' do
    # Arrange
    p = ProductModel.new(height: '14', width: '10', length: '12')

    # Act
    result = p.dimensions()
    
    # Assert
    expect(result).to eq '14 x 10 x 12'
  end
end
