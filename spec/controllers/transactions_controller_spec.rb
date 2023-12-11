require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  render_views # required to access response.body
  before(:example) do
    @user = create(:user1)
    @account = create(:account, user: @user)
    @transaction = create(:transaction1, account: @account)
  end

  context 'not signed in' do
    it 'cannot access new' do
      get :new, params: { account_id: @account.id }
      assert_redirected_to '/users/sign_in'
    end

    it 'cannot access destroy' do
      delete :destroy, params: { id: @transaction.id, account_id: @account.id }
      assert_redirected_to '/users/sign_in'
    end
  end

  context 'signed in' do
    before do
      sign_in @user
    end

    it 'gets access to new' do
      get :new, params: { account_id: @account.id }
      assert_response :success
    end

    it 'creates a new account' do
      post :create, params: { account_id: @account.id,
                              transaction: { payee: "courses", amount: 19.99, date: "2023-11-30", transaction_type: 0, account: @account.id  }
                            }, as: :turbo_stream
      expect(response.media_type).to eq Mime[:turbo_stream]
      expect(response).to render_template(layout: false)
      expect(flash[:notice]).to be_present
      expect(response.body).to include('<turbo-stream action="update" target="new_transaction">')
    end

    it 'renders new if create fails' do
      post :create, params: { account_id: @account.id,
                              transaction: { payee: "courses", amount: 19.99, date: "2023-11-30", account: @account.id  }
                            }
      assert_response :unprocessable_entity
    end

    it 'updates checked' do
      put :update_checked, params: { id: @transaction.id, checked: true }
      assert_redirected_to account_path(@account)
    end

    it 'deletes transaction' do
      target = `<turbo-stream action='remove' target="transaction_#{@transaction.id}">`
      delete :destroy, params: { id: @transaction.id, account_id: @account.id }, as: :turbo_stream
      expect(response.media_type).to eq Mime[:turbo_stream]
      expect(response).to render_template(layout: false)
      expect(flash[:notice]).to be_present
      expect(response.body).to include(target)
    end
  end
end
