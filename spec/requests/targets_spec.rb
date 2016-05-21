require 'rails_helper'

RSpec.describe "Targets", type: :request do
  describe "GET /targets" do
    it "works! (now write some real specs)" do
      get targets_path
      expect(response).to have_http_status(200)
    end
  end
end
