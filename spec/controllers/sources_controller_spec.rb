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

    it 'does not access chosen' do
      @user.sources << @source
      get :chosen
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

    it 'accesses chosen' do
      @user.sources << @source
      get :chosen
      assert_response :success
    end

    it 'adds a new source' do
      post :update, params: { source_ids: [@source.id] }
      assert_redirected_to chosen_sources_path
      expect(@user.sources).to include @source
    end

    it 'deletes sources for user and redirects to index' do
      @user.sources << @source
      expect(@user.sources).to include @source
      post :update, params: { source_ids: [] }
      assert_redirected_to sources_path
      expect(@user.sources.reload).to be_empty
    end
  end
end
