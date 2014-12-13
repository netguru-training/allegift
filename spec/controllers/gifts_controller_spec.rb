require 'rails_helper'

RSpec.describe GiftsController, :type => :controller do

  let(:valid_attributes) do
    {
        name: 'MyString',
        allegro_link: 'allegrolink',
        user_id: 1
    }
  end

  context 'user is signed in' do
    let(:user) { create(:user) }

    before do
      sign_in user
      controller.stub(:user_signed_in?).and_return(true)
      controller.stub(:current_user).and_return(user)
      controller.stub(:authenticate_user!).and_return(user)
    end

    describe "GET index" do
      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
    end

    describe "GET add" do
      it "renders the new template" do
        get :new
        expect(response).to render_template("new")
      end
    end

    describe 'POST create' do

      describe 'with valid params' do
        it 'creates a new Gift' do
          expect {
            post :create, { gift: valid_attributes }
          }.to change(Gift, :count).by(1)
        end
      end

      describe 'with invalid params' do
        it "re-renders the 'new' template" do
          Gift.any_instance.stub(:save).and_return(false)
          post :create, { gift: { 'name' => 'invalid value' } }
          expect(response).to render_template('new')
        end
      end
    end
  end

  context 'user is not signed in' do

    describe "GET index" do
      it "redirects user to login page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET add" do
      it "redirects user to login page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST create' do
      it 'redirects user to login page' do
        post :create, { gift: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
