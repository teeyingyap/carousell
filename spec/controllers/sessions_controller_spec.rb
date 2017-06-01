require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
 
  let(:user) { create(:user, email:"test@example.com", username: "test", password: "12345678") }
  let(:valid_params) {{email: user.email, password: "12345678"}}
  let(:invalid_params) {{email: user.email, password: "1234567"}}

  describe "GET #new" do
 
    before do
      get :new
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end

  end 
 
  describe "POST #create" do
    # happy path
    context "valid log in params" do

      before do
        post :create, params: {session: valid_params}
      end

      it "sets session user_id" do
        expect(session[:user_id]).to eq user.id
      end

      it "redirects to root path" do
        expect(response).to redirect_to(root_path)
      end

    end

    # unhappy path
    context "invalid log in params" do

      before do
        post :create, params: {session: invalid_params}
      end

      it "does not set session user_id" do
        expect(session[:user_id]).to be nil
      end

    end


  end

  describe "DELETE #destroy" do

    before do
      post :create, params: {session: valid_params}
      delete :destroy
    end

    it "deletes the session" do
      expect(session[:user_id]).to eq nil
    end

    it "redirects back to the root path" do
      expect(response).to redirect_to(root_path)
    end
  end
end
