module Utils
  require "i18n"

  class NameUtils
    def self.computerize(name)
      I18n.config.available_locales = :en
      I18n.transliterate(name, :locale => :en)
          .downcase
          .gsub(/\s+/, "_")
          .gsub(/'/, "_")
    end
  end
end