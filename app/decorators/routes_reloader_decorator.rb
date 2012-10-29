Rails::Application::RoutesReloader.class_eval do
  def finalize!
    route_sets.each do |routes|
      ActiveSupport.on_load(:action_controller) { routes.finalize! }
    end
    ActionDispatch::Routing::Translator.translate_from_file("config/locales/routes.yml", engine: Refinery::Core::Engine)
  end
end