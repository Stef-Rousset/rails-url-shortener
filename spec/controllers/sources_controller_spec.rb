require 'rails_helper'

RSpec.describe SourcesController, type: :controller do
  before(:each) do
    @user = create(:user1)
    @user2 = create(:user2)
    @source = create(:source_one)
  end

  context "not signed in" do
    it "can't access index" do
      get :index
      assert_redirected_to new_user_session_path
    end

    it 'does not access choose_sources' do
      get :choose_sources
      assert_redirected_to new_user_session_path
    end
  end

  context "signed in" do
    before do
      sign_in @user
    end

    it 'accesses index' do
      get :index
      assert_response :success
    end

    it 'accesses choose_sources' do
      get :choose_sources
      assert_response :success
    end

    it 'adds a new source' do
      post :add_sources_to_user, params: { source_ids: [@source.id] }
      assert_redirected_to sources_path
      expect(@user.sources).to include @source
    end

    it 'redirects to choose_sources if no sources selected' do
      post :add_sources_to_user, params: { source_ids: [] }
      assert_redirected_to choose_sources_path
      expect(@user.sources).to be_empty
    end
  end
end
