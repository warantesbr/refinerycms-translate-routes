module Refinery
  module TranslateRoutes
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery

      engine_name :refinery_translate_routes

      after_inclusion do

        require 'rails-translate-routes'

        Dir[root.join('app', 'decorators', '**', '*_decorator.rb')].each do |decorator|
          ::Rails.application.config.cache_classes ? require(decorator) : load(decorator)
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::TranslateRoutes)
      end
    end
  end
end
