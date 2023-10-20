require 'rails_helper'

RSpec.describe ShortUrlsController, type: :controller do
  before(:each) do
    @user = create(:user1)
    @user2 = create(:user2)
    @url = create(:short_url1)
    @url2 =  create(:short_url2)
  end

  context "not signed in" do
    it 'accesses index' do
      get :index
      assert_redirected_to new_user_session_path
    end

    it 'does not access show' do
      get :show, params: { id: @url }
      assert_redirected_to new_user_session_path
    end

    it 'does not access new' do
      get :new
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

    it 'accesses show' do
      get :show, params: { id: @url }
      assert_response :success
    end

    it 'accesses new' do
      get :new
      assert_response :success
    end
    #render_views true #needed to get response.body

    #it 'contains only urls created by user' do
    #  get :index
    #  assert_response :success
    #  expect(response.body).to_not include @url2.long_url #created by user2
    #  expect(response.body).to include @url.long_url    #created by user1
    #end

    it 'creates a new short_url' do
      post :create, params: { short_url: {
                                        long_url: "https://guides.rubyonrails.org/testing.html",
                                        user_id: @user,
                                      }
                                    }
      assert_redirected_to short_url_path(ShortUrl.last)
    end

    it 'does not create a short_url if attributes invalid' do
      post :create, params: { short_url: {
                                        long_url: "",
                                        user_id: @user,
                                      }
                                    }
      assert_response :unprocessable_entity
    end

    it 'redirects to long_url' do
      get :url_shortened, params: {url_shortened: @url.tiny_url}
      assert_redirected_to @url.long_url
    end
  end
end
