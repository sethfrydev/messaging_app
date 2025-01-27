Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins Rails.env.production? ? 'https://seth-messaging-app-2f5c57a970bc.herokuapp.com' : '*' # Allow all in dev, restrict in production
    resource '*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
