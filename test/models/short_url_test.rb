require "test_helper"

class ShortUrlTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:user_one)
    @url = short_urls(:one)
  end

  test "should add a tiny_url before validation" do
    one = ShortUrl.create(long_url: "https://www.ffescrime.fr/je-suis-en-club/competiteurs/reglements/", tiny_url: "", user_id: @user.id)
    assert one.valid?
  end

  test "should have a tiny_url with length 7" do
    one = ShortUrl.create(long_url: "https://www.ffescrime.fr/je-suis-en-club/competiteurs/reglements/", tiny_url: "", user_id: @user.id)
    assert 7,  one.tiny_url.length
  end

  test "should have a long_url to be valid" do
    one = ShortUrl.create(long_url: "", tiny_url: "", user_id: @user.id)
    assert_not one.valid?
  end

  #test 'should have a unique tiny_url' do
  #  one = ShortUrl.create(long_url: "https://www.ffescrime.fr/je-suis-en-club/competiteurs/reglements/", tiny_url: "", user_id: @user.id)
  #  assert_raises(ActiveRecord::RecordNotUnique) do
  #    one.update_column("tiny_url",  @url.tiny_url) #update_column ne trigger pas les validations, mais va trigger l'uniqueness en base de donnée
  #  end
  #end

  test 'should check if tiny_url is present or not' do
    presence = ShortUrl.existing_tiny_url?(@url.tiny_url)
    absence = ShortUrl.existing_tiny_url?("xxxxxxx")
    assert_equal true, presence
    assert_equal false, absence
  end

  test 'should generate a random string of 7 characters' do
    string = ShortUrl.generate_tiny_url
    assert_equal String, string.class
    assert_equal 7, string.length
  end

  test 'should eleminate spaces at begining or end of long_url before create' do
    one = ShortUrl.create!(long_url: " https://www.ffescrime.fr/je-suis-en-club/competiteurs/ ", tiny_url: "", user_id: @user.id)
    assert_equal "https://www.ffescrime.fr/je-suis-en-club/competiteurs/", one.long_url
  end
end
