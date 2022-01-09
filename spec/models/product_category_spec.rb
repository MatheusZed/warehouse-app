require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  it 'should not be valid if name is empty' do
    # Arrage
    pc = ProductCategory.new(name: '')

    # Act
    result = pc.valid?

    # Assert
    expect(result).to eq false
  end

  it 'should not be valid if name is duplicate' do
    # Arrage
    ProductCategory.create!(name: 'Conservados')
    pc = ProductCategory.new(name: 'Conservados')

    # Act
    result = pc.valid?

    # Assert
    expect(result).to eq false
  end
end
