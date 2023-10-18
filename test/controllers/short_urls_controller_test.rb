require "test_helper"

class ShortUrlsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'should be redirected to sign_in if trying to access index without being logged_in' do
    get root_path
    assert_redirected_to new_user_session_path
  end

  test 'should access index if logged_in' do
    login_as users(:user_one)
    get root_path
    assert_response :success
    assert_select "h1", "Liste des urls :"
  end

  test 'should show only urls created by current user' do
    login_as users(:user_two)
    get root_path
    assert_response :success
    refute_match short_urls(:one).long_url, @response.body  #created by user_one
    assert_match short_urls(:three).long_url, @response.body #created by user_two
  end

  test 'should access show' do
    @url = short_urls(:one)
    login_as users(:user_one)
    get short_url_path(@url)
    assert_response :success
    @tiny_url = @request.host_with_port + '/' + @url.tiny_url #@request n'est dispo qu'après que la requête ait été faite
    assert_select "h1", "Votre url courte pour:"
    assert_match @url.long_url, @response.body
    assert_match @tiny_url, @response.body
  end

  test 'should create a new short_url' do
    login_as users(:user_one)
    assert_difference("ShortUrl.count", +1) do
      post short_urls_path, params: { short_url: {
                                        long_url: "https://guides.rubyonrails.org/testing.html",
                                        user_id: users(:user_one).id,
                                      }
                                    }
    end
    assert_redirected_to short_url_path(ShortUrl.last)
  end

  test 'url_shortened should redirect to long_url' do
    login_as users(:user_one)
    @url = short_urls(:one)
    get "/#{@url.tiny_url}"
    assert_redirected_to @url.long_url
  end
end
