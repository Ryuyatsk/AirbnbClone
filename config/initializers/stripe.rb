Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
  :secret_key => ENV['STRIPE_SECRET_KEY'],
  :client_id => ENV['STRIPE_CONNECT_CLIENT_ID']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]