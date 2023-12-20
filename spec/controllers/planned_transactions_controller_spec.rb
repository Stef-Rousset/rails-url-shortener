require 'rails_helper'

RSpec.describe PlannedTransactionsController, type: :controller do
  render_views # required to access response.body
  before(:example) do
    @user = create(:user, :normal)
    @account = create(:account, user: @user)
    @planned = create(:planned_transaction, :every_month, account: @account)
  end

  context 'not signed in' do
    it 'cannot access index' do
      get :index
      assert_redirected_to '/users/sign_in'
    end

    it 'cannot access new' do
      get :new
      assert_redirected_to '/users/sign_in'
    end

    it 'cannot access edit' do
      get :edit, params: { id: @planned.id }
      assert_redirected_to '/users/sign_in'
    end

    it 'cannot access destroy' do
      delete :destroy, params: { id: @planned.id }
      assert_redirected_to '/users/sign_in'
    end
  end

  context 'signed in' do
    before do
      sign_in @user
    end

    it 'can access index' do
      get :index
      assert_response :success
    end

    it 'gets access to new' do
      get :new
      assert_response :success
    end

    it 'can access edit' do
      get :edit, params: { id: @planned.id }
      assert_response :success
    end

    it 'creates a new planned transaction' do
      post :create, params: { planned_transaction:
                                { payee: "courses", amount: 19.99, start_date: Date.today + 1.day,
                                  transaction_type: "debit", account_id: @account.id, every: "month"
                                }
                            }
      assert_redirected_to planned_transactions_path
      expect(flash[:notice]).to be_present
    end

    it 'renders new if create fails' do
      post :create, params: { planned_transaction:
                                { payee: "courses", amount: 19.99, start_date: Date.today + 1.day,
                                  account_id: @account.id, every: "month", id: 1
                                }
                            }
      assert_response :unprocessable_entity
    end

    it 'updates planned_transaction' do
      put :update, params: { id: @planned.id,
                             planned_transaction: { amount: 10.0 }
                           }, as: :turbo_stream
      expect(response.media_type).to eq Mime[:turbo_stream]
      expect(response).to render_template(layout: false)
      expect(flash[:notice]).to be_present
      expect(response.body).to include('<turbo-stream action="update" target="edit-planned-modal">')
    end

    it 'deletes transaction' do
      target = `<turbo-stream action='remove' target="planned_transaction_#{@planned.id}">`
      delete :destroy, params: { id: @planned.id }, as: :turbo_stream
      expect(response.media_type).to eq Mime[:turbo_stream]
      expect(response).to render_template(layout: false)
      expect(flash[:notice]).to be_present
      expect(response.body).to include(target)
    end
  end
end
