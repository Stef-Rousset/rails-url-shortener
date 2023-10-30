module SourcesHelper

  def display_name(name)
    case name
      when 'liberation'
        'Libération'
      when 'lemonde'
        'Le Monde'
      when 'lequipe'
        "L'Équipe"
    end
  end
end
