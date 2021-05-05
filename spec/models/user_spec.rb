require 'rails_helper'

describe User do
  it 'is valid with a name, email and encrypted password' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without a name' do
    user = build :user, name: nil
    expect { user.save!(validate: false) }.to raise_error ActiveRecord::NotNullViolation
  end

  it 'is invalid without an email address' do
    user = build :user, email: nil
    expect { user.save!(validate: false) }.to raise_error ActiveRecord::NotNullViolation
  end

  it 'is invalid without a password' do
    user = build :user, encrypted_password: nil
    expect { user.save! }.to raise_error ActiveRecord::NotNullViolation
  end

  it 'is invalid with a duplicate email address' do
    create(
      :user,
      password: 'testpassword012345',
      name: 'TestUser',
      email: 'ola@viola.com'
    )

    user = build(
      :user,
      name: 'TestUser',
      password: 'testpassword012345',
      email: 'ola@viola.com'
    )

    expect { user.save! }.to raise_error ActiveRecord::RecordNotUnique
  end
end
