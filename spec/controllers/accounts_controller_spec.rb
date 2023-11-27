require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  before(:example) do
    @user = create(:user1)
    @account = create(:account, user: @user)
  end
  context 'not signed in' do

    it 'cannot access index' do
      get :index
      assert_redirected_to '/users/sign_in'
    end

    it 'cannot access show' do
      get :show, params: { id: @account }
      assert_redirected_to '/users/sign_in'
    end
  end

  context 'signed in' do
    before do
      sign_in @user
    end

    it 'gets access to index' do
      get :index
      assert_response :success
    end

    it 'gets access to show' do
      get :show, params: { id: @account}
      assert_response :success
    end

    it 'gets access to new' do
      get :new
      assert_response :success
    end

    it 'creates a new account' do
      post :create, params: { account: { name: "livret A",
                                         balance: 100,
                                         user_id: @user
                                        }
                            }
      assert_redirected_to account_path(Account.last)
      expect(flash[:notice]).to be_present
    end

    it 'renders new if create fails' do
      post :create, params: { account: { name: "",
                                         balance: 100,
                                         user_id: @user
                                        }
                            }
      assert_response :unprocessable_entity
    end

    it 'gets access to edit' do
      get :edit, params: { id: @account }
      assert_response :success
    end

    it 'updates an account' do
      put :update, params: { id: @account.id,
                             account: { balance: 50 }
                           }
      assert_redirected_to account_path(@account)
      expect(flash[:notice]).to be_present
    end

    it 'renders edit if update fails' do
      put :update, params: { id: @account.id,
                             account: { balance: "string" }
                           }
      assert_response :unprocessable_entity
    end

    it 'deletes account' do
      delete :destroy, params: { id: @account.id }
      assert_redirected_to accounts_path
      expect(flash[:notice]).to be_present
    end
  end
end
