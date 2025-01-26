Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Allow requests from any origin for development (use specific domains in production)
    resource '*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
