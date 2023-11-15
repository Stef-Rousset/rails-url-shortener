require 'openai'
# Service to handle spell_checker with openai
class HandleOpenai
  def initialize(word)
    @word = word
  end

  def get_word_checked
    begin
      response = client.chat(
        parameters: { model: 'gpt-3.5-turbo',
                      messages: [{ role: 'user', content: "Peux-tu me donner la bonne ortographe du mot français suivant: #{@word}"}],
                      temperature: 0.7 }
      )
      response.dig('choices', 0, 'message', 'content')
    rescue Faraday::ClientError => e # if OpenAI returns an error, ruby-openai will raise a Faraday error
      t(:an_error_occured, my_object: e.response.dig(:body, 'error', 'message'))
    end
  end

  private

  def client
    @client ||= OpenAI::Client.new(acces_token: Rails.application.credentials.openai_api_key)
  end
end


