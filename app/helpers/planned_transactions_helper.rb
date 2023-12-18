module PlannedTransactionsHelper

  def every_translation(word)
    case word
      when "day"
        I18n.locale == :fr ? "jour" : "day"
      when "week"
        I18n.locale == :fr ? "semaine" : "week"
      when "month"
        I18n.locale == :fr ? "mois" : "month"
      when "year"
        I18n.locale == :fr ? "année" : "year"
    end
  end
end
