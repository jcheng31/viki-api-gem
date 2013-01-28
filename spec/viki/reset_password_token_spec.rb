require 'spec_helper'

describe Viki::ResetPasswordToken, api: true do
  it "creates the token from the email" do
    VCR.use_cassette "Viki::ResetPasswordToken_forgot_password!" do
      response = stub
      described_class.should_receive(:create).with({}, {email: 'admin@example.com'}).and_yield(response)
      described_class.forgot_password!('admin@example.com') do |r|
        r.should == response
      end
      Viki.run
    end
  end

  it "resets the password" do
    VCR.use_cassette "Viki::ResetPasswordToken_forgot_password!" do
      response = stub
      described_class.should_receive(:destroy).
        with({}, {reset_password_token: '12345',
                  password: 'pass',
                  password_confirmation: 'pass_conf'}).
        and_yield(response)
      described_class.reset_password!('12345', 'pass', 'pass_conf') do |r|
        r.should == response
      end
      Viki.run
    end
  end

end
