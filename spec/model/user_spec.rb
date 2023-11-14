require 'rails_helper'

describe User, type: :model do
  describe 'associations' do
    it { should have_many(:favorites) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password_digest) }
    it { should validate_uniqueness_of(:api_key)}
    it { should have_secure_password }
  end

  describe 'helper methods' do
    it 'should generate an api key' do
      user = User.create(name: 'test', email: 'test2@test.test', password: 'test', password_confirmation: 'test')

      expect(user.api_key).to_not be_nil
      expect(user.api_key.class).to eq(String)
    end
  end
end