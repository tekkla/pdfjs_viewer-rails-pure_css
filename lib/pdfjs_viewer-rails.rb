require "pdfjs_viewer-rails/version"
require "pdfjs_viewer-rails/helpers"

module PdfjsViewer
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace PdfjsViewer

      initializer "pdfjs_viewer-rails.assets" do |app|
        app.config.assets.paths << root.join("app/assets/pdfjs_viewer")
      end

      initializer "pdfjs_viewer-rails.view_helpers" do
        ActionView::Base.send :include, ViewHelpers
      end
    end
  end
end
