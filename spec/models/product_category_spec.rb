require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  it 'should not be valid if name is empty' do
    # Arrage
    pc = build(:product_category, name: '')

    # Act
    result = pc.valid?

    # Assert
    expect(result).to eq false
  end

  it 'should not be valid if name is duplicate' do
    # Arrage
    create(:product_category, name: 'Conservados')
    pc = build(:product_category, name: 'Conservados')

    # Act
    result = pc.valid?

    # Assert
    expect(result).to eq false
  end
end
