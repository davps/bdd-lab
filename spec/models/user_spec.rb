require 'spec_helper'

describe User do

  def valid_attributes
    {:email => "user@example.com", :password => "123456", :password_confirmation => "123456"}
  end

  it "should create a new instance given valid attributes" do
    FactoryGirl.create(:user)
  end

  describe "email" do
    describe "with invalid params" do
      it "should require a not empty email address" do
        no_email_user = FactoryGirl.build(:user, email: "")
        no_email_user.should_not be_valid
      end
      it "should reject invalid addresses" do
        addresses = %w[user@foo,com user_at_email.org, hello-user@hello.]
        addresses.each do |address|
          invalid_email_user = User.new(valid_attributes.merge(:email => address))
          invalid_email_user.should_not be_valid
        end
      end
    end
    describe "with valid params" do
      it "should be accepted" do
        addresses = %w[user@email.com NEW_USER@example.email.org]
        addresses.each do |address|
          valid_email_user = FactoryGirl.create(:user, email: address)
          valid_email_user.should be_valid
        end
      end
    end
  end

  describe "password" do
    describe "with invalid params" do
      it "should reject a short password" do
        passwords = %w[1 12 123 1234 12345]
        passwords.each do |password|
           invalid_params = {:password => password, :password_confirmation => password}
           invalid_password_user = User.new(valid_attributes.merge(invalid_params))
           invalid_password_user.should be_invalid
        end
      end
      it "should reject if password do not match with password confirmation" do
        invalid_params = {:password_confirmation => "xxxxxxxxxxxxxxx"}
        invalid_password_user = User.new(valid_attributes.merge(invalid_params))
        invalid_password_user.should be_invalid
      end

      it "should reject if no password confirmation" do
        invalid_params = {:password_confirmation => ""}
        invalid_password_user = User.new(valid_attributes.merge(invalid_params))
        invalid_password_user.should be_invalid
      end
    end
    describe "with valid params" do
      it "should acept valid password lenght"  do
        user_with_correct_pass = FactoryGirl.create(:user)
        user_with_correct_pass.should be_valid
      end
    end
  end
end

