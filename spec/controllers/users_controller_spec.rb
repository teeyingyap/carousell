require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_params) {{ username: "jasmine", email: "jasmine@gmail.com", password: "12345678"}}
  let(:invalid_params) {{ username: "jasmine", email: "google.com", password: "12345678"}}
  let(:valid_params_update) {{ username: "jasmine", email: "jasmine@gmail.com", password: "12345678"}}
  let(:invalid_params_update) {{ username: "jasmine", email: "google.com", password: "12345678"}}

  let(:user){User.create(valid_params)}
  let(:user1){User.create(username: "jasmine", email:"jasmine@gmail.com", password: "12345678")}

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

    it "assigns instance user" do
      expect(assigns[:user]).to be_a User
    end
  end
 

  describe "POST #create" do
    # happy_path
    context "valid_params" do
      it "creates new user if params are correct" do
        expect {post :create, params: {:user => valid_params}}.to change(User, :count).by(1)
      end

      it 'redirects to user path and displays flash notice after user created successfully' do
        post :create, params: {user: valid_params }
        expect(response).to redirect_to(User.last)
        expect(flash[:success]).to eq "Welcome to Jarousell!"
      end
    end

    # unhappy_path
    context "invalid_params" do
      it "does not create new user if params are invalid" do
        expect {post :create, params: {:user => invalid_params}}.to change(User, :count).by(0)
      end
    end
  end

 

  describe "GET #edit" do
    before do
      session[:user_id] = user.id
      get :edit, params: {:id => user.to_param}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end

  end


  describe "PUT #update" do
  # happy_path
    context "with valid update params" do
      it "updates the requested user" do
        user = user1
        put :update, params: {:id => user.to_param, :user => valid_params_update}
        user.reload
        expect( user.email ).to eq valid_params_update[:email]
      end

      it 'redirects to user path and displays flash notice after user profile is updated successfully' do

        put :update, params: {:id => user.to_param, :user => valid_params_update}
        user.reload
        expect(response).to redirect_to(user_path(user))
        expect(flash[:notice]).to eq "Your profile is updated successfully."
      end
    end
    # unhappy_path
    context "with invalid update params" do
      it "re-renders the 'edit' template" do
        put :update, params: {:id => user.to_param, :user => invalid_params_update}
        expect(response).to render_template("edit")
      end
    end

  end
end
