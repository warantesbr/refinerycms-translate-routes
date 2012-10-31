# Adapter for Rails 3 apps
ActionDispatch::Routing::Translator.module_eval do
  class << self

    def translate_from_file(file_path, options = {})
      file_path = %w(config locales routes.yml) if file_path.blank?
      return unless File.exist?(file_path)
      engine = options[:engine] || Rails.application
      r = RailsTranslateRoutes.init_from_file(file_path)
      r.prefix_on_default_locale = true if options && options[:prefix_on_default_locale] == true
      r.no_prefixes = true if options && options[:no_prefixes] == true
      r.keep_untranslated_routes = true if options && options[:keep_untranslated_routes] == true
      r.translate engine.routes
    end

  end
end