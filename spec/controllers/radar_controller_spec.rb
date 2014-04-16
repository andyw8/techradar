require 'spec_helper'

describe RadarsController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      expect(response).to be_success
    end
  end

end
