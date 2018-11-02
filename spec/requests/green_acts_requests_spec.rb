require "rails_helper"
require "support/factory_bot"
require "support/devise"

RSpec.describe "green acts request", type: :request do
  let(:user){create :user}

  describe "GET /green_acts/new" do
    context "guest user" do
      it "redirects to sign in page" do
        get "/green_acts/new"
        expect(response).to redirect_to signin_path
      end
    end

    context "signed-in user" do
      before{sign_in user}

      it "renders new green act template" do
        get "/green_acts/new"
        expect(response).to render_template :new
      end
    end
  end

  describe "POST /green_acts" do
    let(:valid_green_act){attributes_for :green_act}

    context "guest user" do
      it "cannot create a new green act in the database" do
        expect do
          post "/green_acts", params: {green_act: valid_green_act}
        end.not_to change(GreenAct, :count)
      end
    end

    context "signed-in user" do
      before{sign_in user}

      context "with valid params" do
        it "creates a new green act in the database" do
          expect do
            post "/green_acts", params: {green_act: valid_green_act}
          end.to change(GreenAct, :count).by(1)
        end
      end

      context "with invalid params" do
        let(:invalid_green_act){attributes_for :green_act, content: ""}

        it "cannot create a new green act in the database" do
          expect do
            post "/green_acts", params: {green_act: invalid_green_act}
          end.not_to change(GreenAct, :count)
        end
      end
    end
  end
end
