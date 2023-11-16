require 'openai'
# Service to handle spell_checker with openai
class HandleOpenai
  def initialize(word, language)
    @word = word
    @language = language
  end

  def get_word_checked
    @content =
      if @language == 'fr'
        "Peux-tu me donner la bonne ortographe du mot français: #{@word}"
      else
        "Can you give me the correct spelling for the english word: #{@word}"
      end

    begin
      response = client.chat(
        parameters: { model: 'gpt-3.5-turbo',
                      messages: [{ role: 'user', content: @content }],
                      temperature: 0.7 }
      )
      response.dig('choices', 0, 'message', 'content')
    rescue Faraday::ClientError => e # if OpenAI returns an error, ruby-openai will raise a Faraday error
      t(:an_error_occured, my_object: e.response.dig(:body, 'error', 'message'))
    end
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end
end

