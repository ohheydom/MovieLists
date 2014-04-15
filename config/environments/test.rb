require 'diagnostic'
MyMovieTracker::Application.configure do
  config.cache_classes = true

  config.eager_load = false
  config.middleware.use(MyMovieTracker::DiagnosticMiddleware)
  config.serve_static_assets  = true
  config.static_cache_control = "public, max-age=3600"
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = false
  config.action_controller.allow_forgery_protection = false
  config.action_mailer.delivery_method = :test
  config.cache_store = :redis_store, { :expires_in => 20.minutes }
  config.active_support.deprecation = :stderr
end
