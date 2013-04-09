RailsTranslateRoutes::Translator.module_eval do

  # Translate a specific RouteSet, usually Rails.application.routes, but can
  # be a RouteSet of a gem, plugin/engine etc.
  def translate route_set
    Rails.logger.info "Translating routes (default locale: #{default_locale})" if defined?(Rails) && defined?(Rails.logger)

    # save original routes and clear route set
    original_routes = route_set.routes.dup

    if Rails.version >= '3.2'
      original_routes.routes.delete_if{|r| r.path.spec.to_s == '/assets'  }
    else
      original_routes.delete_if{|r| r.path == '/assets'}
    end

    original_named_routes = route_set.named_routes.routes.dup  # Hash {:name => :route}

    if Rails.version >= '3.2'
      translated_routes = []
      original_routes.each do |original_route|
        translations_for(original_route).each do |translated_route_args|
          translated_routes << translated_route_args
        end
      end

      reset_route_set route_set

      translated_routes.each do |translated_route_args|
        route_set.add_route *translated_route_args
      end
    else
      reset_route_set route_set

      original_routes.each do |original_route|
        translations_for(original_route).each do |translated_route_args|
          route_set.add_route *translated_route_args
        end
      end
    end

    original_named_routes.each_key do |route_name|
      route_set.named_routes.helpers.concat add_untranslated_helpers_to_controllers_and_views(route_name, route_set)
    end

    if root_route = original_named_routes[:root]
      add_root_route root_route, route_set
    end

  end


  # Add standard route helpers for default locale e.g.
  #   I18n.locale = :de
  #   people_path -> people_de_path
  #   I18n.locale = :fr
  #   people_path -> people_fr_path
  # Helpers of routes defined in engines such as blog_post_path didn't work as they relied on a blog_post_es_path method that didn't exist in ActionView::BAse or ActionController::Base.
  # That's why we must call blog_post_es_path at the url_helpers module of the engine
  def add_untranslated_helpers_to_controllers_and_views old_name, route_set = nil

    ['path', 'url'].map do |suffix|

      new_helper_name = "#{old_name}_#{suffix}"

      containers = [
        route_set.url_helpers,
        ActionController::Base,
        ActionView::Base,
        ActionMailer::Base,
        ActionDispatch::Routing::UrlFor
      ]

      containers.each do |helper_container|
        helper_container.module_eval do

            self.send :define_method, new_helper_name.to_sym do |*args|
              if suffix == "url"
                options = args.extract_options!
                args << url_options.merge((options || {}).symbolize_keys)
              end
              route_set.url_helpers.send "#{old_name}_#{locale_suffix(I18n.locale)}_#{suffix}", *args
            end

        end
      end

      new_helper_name.to_sym
    end

  end

  # Generate translations for a single route for all available locales
  def translations_for route
    translated_routes = []

    available_locales.map do |locale|
      translated_routes << translate_route(route, locale) if  locale != I18n.default_locale.to_s
    end

    translated_routes << translate_route(route, I18n.default_locale.to_s)

    # add untranslated_route without url helper if we want to keep untranslated routes
    # We also keep untranslated all the /refinery/* routes
    translated_routes << untranslated_route(route) if @keep_untranslated_routes ||  route.path.spec.to_s.start_with?('/refinery')
    translated_routes
  end

end
