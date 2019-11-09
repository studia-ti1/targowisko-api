# frozen_string_literal: true

module ExceptionsHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from CustomExceptions::AuthenticationError, with: :token_error

    def record_not_found(_)
      render json: { errors: ['The object with given id could not be found'] }, status: :not_found
    end

    def record_invalid(err)
      render json: err.record.errors.messages, status: :unprocessable_entity
    end

    def token_error
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end
  end
end
