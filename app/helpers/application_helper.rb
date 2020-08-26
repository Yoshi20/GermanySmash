module ApplicationHelper

  def flash_class(level)
    case level.to_sym
      when :notice then "alert-info"
      when :success then "alert-success"
      when :error then "alert-danger"
      when :alert then "alert-warning"
    end
  end

  # # to keep the sort and order parameters
  # def table_params
  #   {
  #     sort: params[:sort],
  #     order: params[:order],
  #     order_by_letter: params[:order_by_letter],
  #     search: params[:search],
  #     limit: params[:limit],
  #   }
  # end

  def unaccent(text)
    charactersProcessed = "" # To avoid doing a replace multiple times
    newText = text.downcase
    text = newText # Case statement is expecting lowercase
    text.each_char do |c|
      next if  charactersProcessed.include? c
      replacement = ""
      case c
        when '1'
          replacement = "¹"
        when '2'
          replacement = "²"
        when '3'
          replacement = "³"
        when 'a'
          replacement = "á|à|â|ã|ä|å|ā|ă|ą|À|Á|Â|Ã|Ä|Å|Ā|Ă|Ą|Æ"
        when 'c'
          replacement = "ć|č|ç|©|Ć|Č|Ç"
        when 'e'
          replacement = "è|é|ê|ё|ë|ē|ĕ|ė|ę|ě|È|Ê|Ë|Ё|Ē|Ĕ|Ė|Ę|Ě|€"
        when 'g'
          replacement = "ğ|Ğ"
        when 'i'
          replacement = "ı|ì|í|î|ï|ì|ĩ|ī|ĭ|Ì|Í|Î|Ï|Ї|Ì|Ĩ|Ī|Ĭ"
        when 'l'
          replacement = "ł|Ł"
        when 'n'
          replacement = "ł|Ł"
        when 'n'
          replacement = "ń|ň|ñ|Ń|Ň|Ñ"
        when 'o'
          replacement = "ò|ó|ô|õ|ö|ō|ŏ|ő|ø|Ò|Ó|Ô|Õ|Ö|Ō|Ŏ|Ő|Ø|Œ"
        when 'r'
          replacement = "ř|®|Ř"
        when 's'
          replacement = "š|ş|ș|ß|Š|Ş|Ș"
        when 'u'
          replacement = "ù|ú|û|ü|ũ|ū|ŭ|ů|Ù|Ú|Û|Ü|Ũ|Ū|Ŭ|Ů"
        when 'y'
          replacement = "ý|ÿ|Ý|Ÿ"
        when 'z'
          replacement = "ž|ż|ź|Ž|Ż|Ź"
      end
      if !replacement.empty?
        charactersProcessed = charactersProcessed + c
        newText = newText.gsub(c, "(" + c + "|" + replacement + ")")
      end
    end
    return newText
  end

end
