require 'rails_helper'

RSpec.describe SourcesController, type: :controller do
  before(:each) do
    @user = create(:user, :normal)
    @source = create(:source_one)
  end

  context "not signed in" do
    it "can't access index" do
      get :index
      assert_redirected_to '/users/sign_in'
    end

    it 'does not access choose_sources' do
      get :choose_sources
      assert_redirected_to '/users/sign_in'
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
      post :update_sources_for_user, params: { source_ids: [@source.id] }
      assert_redirected_to sources_path
      expect(@user.sources).to include @source
    end

    it 'deletes sources for user and redirects to choose_sources' do
      @user.sources << @source
      expect(@user.sources).to include @source
      post :update_sources_for_user, params: { source_ids: [] }
      assert_redirected_to choose_sources_path
      expect(@user.sources.reload).to be_empty
    end
  end
end
