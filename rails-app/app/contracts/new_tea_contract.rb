class NewTeaContract < ApplicationContract
  SUPPORTED_COUNTRIES = %w[pl en de]

  json do
    required(:name).filled(:string, min_size?: 2, max_size?: 1024)
    required(:country).filled(:string, size?: 2, included_in?: SUPPORTED_COUNTRIES)
    optional(:invalid).filled(:bool)
  end
end
