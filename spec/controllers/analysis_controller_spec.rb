require 'rails_helper'

RSpec.describe AnalysisController, type: :controller do

  describe "GET #index not admin" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(404)
    end
  end

end
