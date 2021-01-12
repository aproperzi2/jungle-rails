require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation" do 
    it "is valid with valid attributes" do
      @user = User.new(first_name: "Luca", last_name: "Properzi", email: "luca@gmail.com", password: "12345", password_confirmation: "12345")
      expect(@user).to be_valid
    end
    
    it "must be created with first name" do
      @user = User.new(first_name: nil, last_name: "Properzi", email: "luca@gmail.com", password: "12345", password_confirmation: "12345")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "must be created with last name" do
      @user = User.new(first_name: "Luca", last_name: nil, email: "luca@gmail.com", password: "12345", password_confirmation: "12345")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "must be created with email" do
      @user = User.new(first_name: "Luca", last_name: "Properzi", email: nil, password: "12345", password_confirmation: "12345")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "must be created with unique email" do
      @user = User.new(first_name: "Luca", last_name: "Properzi", email: "luca@gmail.com", password: "12345", password_confirmation: "12345")
      @user.save!
      @user1 = User.new(first_name: "Lucas", last_name: "Properzi", email: "LUCA@gmail.com", password: "12345", password_confirmation: "12345")
      expect(@user1).to_not be_valid
      expect(@user1.errors.full_messages).to include("Email has already been taken")
    end

    it "must be created with password and password confirmation" do
      @user = User.new(first_name: "Luca", last_name: "Properzi", email: "luca@gmail.com", password: nil, password_confirmation: nil)
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "password and password confirmation must match" do 
      @user = User.new(first_name: "Luca", last_name: "Properzi", email: "luca@gmail.com", password: "12345", password_confirmation: "654987")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end 

    it "password must be longer than 5 characters" do
      @user = User.new(first_name: "Luca", last_name: "Properzi", email: "luca@gmail.com", password: "1234", password_confirmation: "1234")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end
  end

  describe "authenticate with credentials" do 
    it "authenticates the user with proper credentials and logs them in" do 
      @user = User.new(first_name: "Luca", last_name: "Properzi", email: "luca@gmail.com", password: "12345", password_confirmation: "12345")
      @user.save!
      expect(@user.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
    end

    it "authenticates the user with invalid password and forbids them to" do
      @user = User.new(first_name: "Luca", last_name: "Properzi", email: "luca@gmail.com", password: "12345", password_confirmation: "12345")
      @user.save!
      expect(@user.authenticate_with_credentials(@user.email, "wrong password")).to eq(nil)
    end

    it "authenticates the user with invalid credentials and forbids them to" do
      @user = User.new(first_name: "Luca", last_name: "Properzi", email: "luca@gmail.com", password: "12345", password_confirmation: "12345")
      @user.save!
      expect(@user.authenticate_with_credentials("wrong email", @user.password)).to eq(nil)
    end

    it "authenticates the user with valid email but with spaces before and after" do
      @user = User.new(first_name: "Luca", last_name: "Properzi", email: "luca@gmail.com", password: "12345", password_confirmation: "12345")
      @user.save!
      expect(@user.authenticate_with_credentials("   luca@gmail.com   ", @user.password)).to eq(@user)
    end

    it "authenticates the user with valid password but with spaces before and after" do
      @user = User.new(first_name: "Luca", last_name: "Properzi", email: "luca@gmail.com", password: "12345", password_confirmation: "12345")
      @user.save!
      expect(@user.authenticate_with_credentials(@user.email, "   12345   ")).to eq(@user)
    end
    
    it "authenticates the user with valid email but with uppercase" do
      @user = User.new(first_name: "Luca", last_name: "Properzi", email: "luca@gmail.com", password: "12345", password_confirmation: "12345")
      @user.save!
      expect(@user.authenticate_with_credentials("   LUCA@GMAIL.COM   ", @user.password)).to eq(@user)
    end
  end
end
