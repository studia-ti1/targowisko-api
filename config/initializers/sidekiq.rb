# frozen_string_literal: true

require 'sidekiq/job_retry'

Sidekiq.options[:max_retries] = 0
if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = {
      url: Rails.application.secrets.redis_url,
      password: Rails.application.secrets.redis_auth
    }
  end

  Sidekiq.configure_client do |config|
    config.redis = {
      url: Rails.application.secrets.redis_url,
      password: Rails.application.secrets.redis_auth,
      size: 3
    }
  end
end
