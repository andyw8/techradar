require "rails_helper"

describe HomeController do
  describe "GET 'index'" do
    specify do
      get "show"
      expect(response).to be_success
    end
  end
end
