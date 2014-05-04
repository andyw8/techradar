require 'spec_helper'

describe User do
  let(:attr) do
    {
      name: "Example User",
      email: "user@example.com",
      password: "changeme",
      password_confirmation: "changeme"
    }
  end

  it "should create a new instance given a valid attribute" do
    expect { User.create!(attr) }.not_to raise_error
  end

  it { should validate_presence_of(:email) }

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(attr.merge(email: address))
      expect(valid_email_user).to be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(attr.merge(email: address))
      expect(invalid_email_user).not_to be_valid
    end
  end

  it { should validate_uniqueness_of(:email).case_insensitive }

  describe "passwords" do
    let(:user) { User.new(attr) }

    it "should have a password attribute" do
      expect(user).to respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      expect(user).to respond_to(:password_confirmation)
    end
  end

  describe "password validations" do
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
    it { should ensure_length_of(:password).is_at_least(8) }
  end

  describe "password encryption" do
    let(:user) { User.create!(attr) }

    it "should have an encrypted password attribute" do
      expect(user).to respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      expect(user.encrypted_password).not_to be_blank
    end
  end
end
