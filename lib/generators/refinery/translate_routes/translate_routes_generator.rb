module Refinery
  class TranslateRoutesGenerator < Rails::Generators::Base

    source_root File.expand_path("../templates", __FILE__)

    def generate_routes_yml
      template "config/locales/routes.yml.erb", File.join(destination_root, "config", "locales", "routes.yml")
    end

  end
end