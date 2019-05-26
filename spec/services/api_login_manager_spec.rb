require 'rails_helper'

# Los skips sirven para prevenir la ejecución del it, así que es necesario
# borrarlos (en su lugar implementen los tests, no sean vagos).

RSpec.describe ApiLoginManager do
  # Idealmente la contraseña del usuario estaría encriptada en la base
  # de datos, por lo que no vamos a poder recuperarla del usuario para
  # utilizarla. Es por eso que conviene usarla desde una variable con
  # let!(:password) { SecureRandom.hex }. Al crear el usuario,
  # en let!(:user) { ... }, usar esta variable.
  let!(:password) { SecureRandom.hex }

  let!(:user) { FactoryBot.create(:user, password: password) } # -- crear usuario con FactoryBot -- #

  describe '#call' do
    context 'when user provided data is valid' do
      before do
        # Realizar un stub del ExternalValidator para que se ejecuta realmente
        allow(ExternalValidator).to receive(:call).with(user.email).and_return(true)
      end

      subject do
        described_class.new(email: user.email, password: password).call
      end

      it "update user's auth_token" do
        # skip 'Una vez que definan a user, este test va a fallar. ¿Por qué?'
        # porque user queda cacheado, tenes que hacer un reload de user
        expect { subject }.to change { user.reload.auth_token }
      end

      it 'returns the auth_token' do
        is_expected.to eq(user.reload.auth_token)
      end
    end

    context 'when no email is provided' do
      let(:api_log_manager) { described_class.new(password: password) }
      subject { api_log_manager.call }

      it 'returns false' do
        is_expected.to be_falsey
      end

      it 'returns EMPTY_EMAIL error with a reader' do
        expect { subject }.to change { api_log_manager.error }.to(described_class::EMPTY_EMAIL)
      end
    end

    context 'when no password is provided' do
      let(:api_log_manager) { described_class.new(email: user.email) }
      subject { api_log_manager.call }

      it 'returns false' do
        is_expected.to be_falsey
      end

      it 'returns EMPTY_PASSWORD error with a reader' do
        expect { subject }.to change { api_log_manager.error }.to(described_class::EMPTY_PASSWORD)
      end
    end

    context 'when the email is incorrect' do
      let(:api_log_manager) { described_class.new(email: 'cualquier_cosa', password: password) }
      subject { api_log_manager.call }

      it 'returns false' do
        is_expected.to be_falsey
      end

      it 'returns USER_NOT_FOUND error with a reader' do
        expect { subject }.to change { api_log_manager.error }.to(described_class::USER_NOT_FOUND)
      end
    end

    context 'when the password is incorrect' do
      let(:api_log_manager) { described_class.new(email: user.email, password: 'saraza') }
      subject { api_log_manager.call }

      it 'returns false' do
        is_expected.to be_falsey
      end

      it 'returns WRONG_PASSWORD error with a reader' do
        expect { subject }.to change { api_log_manager.error }.to(described_class::WRONG_PASSWORD)
      end
    end

    context 'when ExternalValidator fails' do
      let(:api_log_manager) { described_class.new(email: user.email, password: password) }

      before do
        allow(ExternalValidator).to receive(:call).with(user.email).and_return(false)
      end

      subject { api_log_manager.call }

      it { is_expected.to be_falsey }

      it 'returns EXTERNAL_VALIDATOR error with a reader' do
        expect { subject }.to change { api_log_manager.error }.to(described_class::EXTERNAL_VALIDATOR)
      end

    end

    # Definir un nuevo context para cuando la conexión
    # con ExternalValidator falla. Acá los quiero ver...
  end
end
