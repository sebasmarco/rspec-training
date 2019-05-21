require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Factory' do
    it 'has a valid factory' do
      # Testear que el factory definido es válido.
    end
  end

  describe 'Associations' do
    # Testear asociaciones (shoulda-matchers).
    # https://github.com/thoughtbot/shoulda-matchers#activerecord-matchers
  end

  describe 'Presence validations' do
    # Testear validaciones de presencia (shoulda-matchers).
    # https://github.com/thoughtbot/shoulda-matchers#activemodel-matchers
  end

  describe 'Uniqueness validations' do
    # Testear validaciones de unicidad (shoulda-matchers).
    # https://github.com/thoughtbot/shoulda-matchers#activemodel-matchers
  end

  describe 'Length validations' do
    # Testear validaciones de longitud (shoulda-matchers).
    # https://github.com/thoughtbot/shoulda-matchers#activemodel-matchers
  end

  describe 'Enumeratives' do
    # Testear definición de enumerativos (shoulda-matchers).
  end

  # Testear métodos de instancia y de clase como para el caso de cualquier
  # otra clase Ruby (similar a testear ApiLoginManager).
  describe '#valid_password?' do
    # Testear funcionamiento de método. Podemos definir dos contexts:
    #  - 'when given value is different from password'
    #  - 'when given value is equal to password'
  end
end
