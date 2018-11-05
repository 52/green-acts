require "rails_helper"
require "support/factory_bot"
require "support/devise"

RSpec.describe "green acts requests", type: :request do
  let(:user){create :user}
  let(:owner){create :user}
  let!(:green_act){create :green_act, user: owner}

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

  describe "GET /green_acts/:id/edit" do
    context "guest user" do
      it "redirects to sign in page" do
        get "/green_acts/#{green_act.id}/edit"
        expect(response).to redirect_to signin_url
      end
    end

    context "signed-in user but not owner" do
      before{sign_in user}

      it "redirects to the home page" do
        get "/green_acts/#{green_act.id}/edit"
        expect(response).to redirect_to root_url
      end
    end

    context "owner" do
      before{sign_in owner}

      it "renders the edit template" do
        get "/green_acts/#{green_act.id}/edit"
        expect(response).to render_template :edit
      end
    end
  end

  describe "PATCH /green_acts/:id" do
    shared_examples "cannot update" do
      it "does not update information in the database" do
        patch "/green_acts/#{green_act.id}",
              params: {green_act: {content: "I actually did this"}}
        expect do
          green_act.reload
        end.not_to change(green_act, :content)
      end
    end

    context "guest user" do
      include_examples "cannot update"
    end

    context "signed-in user but not owner" do
      before{sign_in user}
      include_examples "cannot update"
    end

    context "owner" do
      before{sign_in owner}

      it "does update information in the database" do
        patch "/green_acts/#{green_act.id}",
              params: {green_act: {content: "I actually did this"}}
        expect do
          green_act.reload
        end.to change(green_act, :content).to "I actually did this"
      end
    end
  end

  describe "DELETE /green_acts/:id" do
    shared_examples "cannot delete" do
      it "cannot delete the green act from database" do
        expect do
          delete "/green_acts/#{green_act.id}"
        end.not_to change(GreenAct, :count)
      end
    end

    context "guest user" do
      include_examples "cannot delete"
    end

    context "signed-in user but not owner" do
      before{sign_in user}
      include_examples "cannot delete"
    end

    context "owner" do
      before{sign_in owner}
      it "can delete his own green act from database" do
        expect do
          delete "/green_acts/#{green_act.id}"
        end.to change(GreenAct, :count).by(-1)
      end
    end
  end
end
