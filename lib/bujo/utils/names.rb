module Utils
  require "i18n"

  class NameUtils
    def self.computerize(name)
      I18n.transliterate(name.downcase).gsub(/\s+/, "_")
    end
  end
end