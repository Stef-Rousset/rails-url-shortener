require "openai"
# Service to handle spell_checker with openai
class HandleOpenai
  def initialize(word)
    @word = word
  end

  def get_word_checked
    #response = client.edits(
    #    parameters: {
    #        model: "text-davinci-edit-001",
    #        input: @word,
    #        instruction: "Corrige les fautes d'ortographe"
    #    }
    #)
    #response.dig("choices", 0, "text")
    begin
      response = client.chat(
      parameters: {
          model: "gpt-3.5-turbo", # Required.
          messages: [{ role: "user", content: "Corrige l'ortographe du mot français suivant: #{@word}"}], # Required.
          temperature: 0.7,
      })
      response.dig("choices", 0, "message", "content")
    rescue Faraday::ClientError => error
      error.response.dig(:body, "error", "message")
    end
  end

  private

  def client
    @client ||= OpenAI::Client.new(acces_token: Rails.application.credentials.openai_api_key)
  end
end



