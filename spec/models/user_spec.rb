require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'must be created with a password and password_confirmation fields' do
      user = User.new(email: 'test@example.com', first_name: 'John', last_name: 'Doe')
      user.password = nil
      user.password_confirmation = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'password and password_confirmation must match' do
      user = User.new(email: 'test@example.com', first_name: 'John', last_name: 'Doe', password: 'password', password_confirmation: 'notmatch')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'email, first name, and last name should be required' do
      user = User.new
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank", "First name can't be blank", "Last name can't be blank")
    end

    it 'emails must be unique (not case sensitive)' do
      User.create(email: 'test@example.com', first_name: 'John', last_name: 'Doe', password: 'password', password_confirmation: 'password')
      user = User.new(email: 'TEST@example.com', first_name: 'Jane', last_name: 'Doe', password: 'password', password_confirmation: 'password')
      user.valid?
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'must have a minimum length for the password' do
      user = User.new(email: 'test@example.com', first_name: 'John', last_name: 'Doe', password: 'pass', password_confirmation: 'pass')
      user.valid?
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '#authenticate_with_credentials' do
    before do
      @user = User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    it 'returns the user when email and password are correct' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'returns nil when email is incorrect' do
      authenticated_user = User.authenticate_with_credentials('wrong@example.com', 'password')
      expect(authenticated_user).to be_nil
    end

    it 'returns nil when password is incorrect' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrong_password')
      expect(authenticated_user).to be_nil
    end

    it 'returns nil when both email and password are incorrect' do
      authenticated_user = User.authenticate_with_credentials('wrong@example.com', 'wrong_password')
      expect(authenticated_user).to be_nil
    end

    it 'returns the user when email has leading/trailing spaces' do
      authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'returns the user when email has different cases' do
      authenticated_user = User.authenticate_with_credentials('TeSt@ExAmPlE.com', 'password')
      expect(authenticated_user).to eq(@user)
    end
  end
end
