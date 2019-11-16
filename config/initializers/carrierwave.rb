CarrierWave.configure do |config|
  config.azure_storage_account_name = Rails.application.secrets.azure_storage_account_name
  config.azure_storage_access_key = Rails.application.secrets.azure_storage_access_key
  config.azure_container = Rails.application.secrets.azure_container
  config.cache_storage = :file
end