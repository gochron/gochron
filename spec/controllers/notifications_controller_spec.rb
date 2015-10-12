require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do

  describe "GET #notify" do
    it "returns http success" do
      get :notify
      expect(response).to have_http_status(:success)
    end
  end

end
