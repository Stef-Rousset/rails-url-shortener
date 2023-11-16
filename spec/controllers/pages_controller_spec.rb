require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  render_views # required to access response.body
  before(:each) do
    @user = create(:user1)
    @user2 = create(:user2)
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

    it "can't access spell_checker" do
      get :spell_checker
      assert_redirected_to new_user_session_path
    end
  end

  context 'signed in' do
    before do
      sign_in @user
    end

    it 'accesses weather' do
      get :weather
      assert_response :success
    end

    it 'accesses spell_checker' do
      get :spell_checker
      assert_response :success
    end

    it 'renders spell_checker with flash message if spell_count is 5' do
      # @user has 5 spell_counts
      post :spell_checked, params: { search: 'bouteile', language: 'fr' }
      expect(response).to render_template(:spell_checker)
      expect(flash[:alert]).to be_present
    end
  end

  it 'add 1 spell_count to user and respond with turbo_stream' do
    sign_in @user2 # @user2 has 0 spell_count
    post :spell_checked, params: { search: 'bouteile', language: 'fr' }, as: :turbo_stream
    # as: :turbo_stream required for test
    expect(response.media_type).to eq Mime[:turbo_stream]
    expect(response).to render_template(layout: false)
    expect(response.body).to include('<turbo-stream action="update" target="response">')
  end
end
