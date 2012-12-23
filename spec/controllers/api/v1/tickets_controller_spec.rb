require 'spec_helper'

describe API::V1::TicketsController do

  describe "POST /cas/v1/tickets" do
    context "with correct credentials" do

      before do
        CASinoCore::Processor::LoginCredentialRequestor.any_instance.should_receive(:process) do
          @controller.user_logged_in nil, "TGT-long-string"
        end

        post :create, params: {username: 'valid', password: 'valid'}
      end

      subject { response }
      its(:response_code) { should eq 201 }
      its(:location) { should eq 'http://test.host/cas/v1/tickets/TGT-long-string' }
    end

    context "with incorrect credentials" do

      before do
        CASinoCore::Processor::LoginCredentialRequestor.any_instance.should_receive(:process) do
          @controller.invalid_login_credentials mock()
        end

        post :create, params: {username: 'invalid', password: 'invalid'}
      end

      subject { response }
      its(:response_code) { should eq 400 }
    end
  end

  describe "POST /cas/v1/tickets/{TGT id}" do
  end

  describe "DELETE /cas/v1/tickets/TGT-fdsjfsdfjkalfewrihfdhfaie" do
  end

end
