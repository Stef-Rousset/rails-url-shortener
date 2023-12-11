require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  before(:example) do
    @user = create(:user1)
    @category = create(:category, user: @user)
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
  end

  context 'signed in' do
    before do
      sign_in @user
    end

    it 'gets access to index' do
      get :index
      assert_response :success
    end

    it 'gets access to new' do
      get :new
      assert_response :success
    end

    it 'creates a new category' do
      post :create, params: { category: { name: 'Vacances',
                                         user_id: @user
                                        }
                            }
      assert_redirected_to categories_path
      expect(flash[:notice]).to be_present
    end

    it 'renders new if create fails' do
      Category.skip_callback(:validation, :before, :capitalize)
      post :create, params: { category: { name: '',
                                         user_id: @user
                                        }
                            }
      assert_response :unprocessable_entity
    end

    it 'destroys category' do
      cate = Category.create(name: "bla", user: @user)
      delete :destroy, params: { id: cate.id }
      assert_redirected_to categories_path
    end
  end
end
