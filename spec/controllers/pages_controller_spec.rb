require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  before(:each) do
    @user = create(:user1)
  end

  context "not signed in" do
    it 'accesses home' do
      get :home
      assert_response :success
    end

    it 'accesses about' do
      get :about
      assert_response :success
    end

    it "can't access weather" do
      get :weather
      assert_redirected_to new_user_session_path
    end
  end

  context "signed in" do
    before do
      sign_in @user
    end

    it 'accesses weather' do
      get :weather
      assert_response :success
    end

  end
end
