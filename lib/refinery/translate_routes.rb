require 'refinerycms-core'

module Refinery

  module TranslateRoutes
    require 'refinery/translate_routes/engine'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [  ]
      end
    end

  end
end
