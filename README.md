# pdfjs_viewer-rails-pure_css

[![Build Status](https://travis-ci.org/senny/pdfjs_viewer-rails.svg?branch=master)](https://travis-ci.org/senny/pdfjs_viewer-rails)

## Summary of Changes (Pure CSS Fork)

This fork updates the gem to work with **Rails 8.1+** and the **Propshaft** asset pipeline. Key changes include:

*   **Pure CSS**: Removed `sassc-rails` dependency and converted SCSS to standard CSS.
*   **No Node.js Required**: The gem no longer requires a JavaScript runtime (Node.js) for asset compilation.
*   **Asset Pipeline**:
    *   JS and CSS are handled by Propshaft.
    *   Static resources (locales, cmaps) are served via `ActionDispatch::Static` from the engine's public folder to avoid issues with asset fingerprints in AJAX requests.
*   **Fixes**: Corrected viewer style application (minimal/reduced) and localization file loading.

## Motivation

These changes were necessary when moving from Rails 7 to Rails 8 with **Propshaft** and **Importmaps**, as the original gem didn't work in this environment. The goal was to remove the SCSS/Node.js dependencies and ensure assets load correctly in modern Rails apps.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "pdfjs_viewer-rails", github: "tekkla/pdfjs_viewer-rails-pure_css"
```

This gem depends on `propshaft`.

## Viewer Styles

This gem ships with three viewer styles:

**full**

<p align="center">
  <img
  src="https://raw.githubusercontent.com/senny/pdfjs_viewer-rails/master/doc/files/viewer_full.png"
  alt="full style"/>
</p>

**reduced**

<p align="center">
  <img
  src="https://raw.githubusercontent.com/senny/pdfjs_viewer-rails/master/doc/files/viewer_reduced.png"
  alt="reduced style"/>
</p>

**minimal**

<p align="center">
  <img
  src="https://raw.githubusercontent.com/senny/pdfjs_viewer-rails/master/doc/files/viewer_minimal.png"
  alt="minimal style"/>
</p>

## Usage

### Using the mountable Engine

The mountable engine makes it extremely simple to integrate the PDF.js viewer
into your application:

*config/routes.rb*
```ruby
mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'
```

Now you can use a link in your templates to open up the viewer:

```erb
<%= link_to "display using the full viewer", pdfjs.full_path(file: "/sample.pdf") %>
<%= link_to "display using the minimal viewer", pdfjs.minimal_path(file: "/sample.pdf") %>
```

### Using the helper

If your integration scenario is more complex you may want to consider using the
`pdfjs_viewer` helper. This allows you to embed the viewer into a container like
an iframe.

```erb
<%= pdfjs_viewer pdf_url: "/sample.pdf", style: :full %>
<%= pdfjs_viewer pdf_url: "/sample.pdf", style: :minimal %>
```

NOTE: The helper will render a full HTML document and should not be used in a layout.

### Verbosity of PDF.js

The verbosity of PDF.js can be set with:

```bash
$ export PDFJS_VIEWER_VERBOSITY=warnings
```

Verbosity levels:

* errors (default)
* warnings
* infos

### Customizing the viewer

If you're not happy with the 3 different styles with which pdfjs_viewer-rails is shipped, you can make your own adjustments by creating a file in `app/views/pdfjs_viewer/viewer/_extra_head.html.erb`. This file will be appended to the viewer's `<head>` tag.

So for example, if you'd like to hide the print icon:

```erb
<!-- app/views/pdfjs_viewer/viewer/_extra_head.html.erb -->

<style>
  #print { display: none; }
</style>
```

NOTE: You can use the parameters you passed into `pdfjs_viewer` (if you're using the helper):

```erb
<!-- Somewhere in a view in your project -->
<%= pdfjs_viewer style: "reduced", something: "extra_data" %>
```

and then access them:

```erb
<!-- app/views/pdfjs_viewer/viewer/_extra_head.html.erb -->

<%= tag.meta name: "something", content: local_assigns[:something] %>
```

### Setting up CORS

If you plan to load PDFs that are hosted on another domain from the
PDF.js viewer, you may need to set up a Cross-Origin Resource Sharing (CORS)
Policy to allow PDF.js to read PDFs from your domain. If you're serving PDFs
straight from Amazon S3 (e.g. `bucket.s3-us-west-1.amazonaws.com`), you will
need to add a CORS policy to the S3 bucket.

## Development

Tests can be executed with:

```bash
$ bin/rake
```

This will render the sample.pdf using headless chrome and save screenshots into `test/sandbox`.

## License

pdfjs_viewer-rails is released under the [MIT License](http://www.opensource.org/licenses/MIT).
