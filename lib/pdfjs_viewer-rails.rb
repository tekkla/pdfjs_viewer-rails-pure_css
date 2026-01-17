require "pdfjs_viewer-rails/version"
require "pdfjs_viewer-rails/helpers"

module PdfjsViewer
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace PdfjsViewer

      initializer "pdfjs_viewer-rails.assets" do |app|
        app.middleware.insert_before(ActionDispatch::Static, ActionDispatch::Static, root.join("public").to_s, index: 'index', headers: app.config.public_file_server.headers)
      end

      initializer "pdfjs_viewer-rails.view_helpers" do
        ActionView::Base.send :include, ViewHelpers
      end
    end
  end
end
