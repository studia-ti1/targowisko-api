# frozen_string_literal: true

module ExceptionsHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from CustomExceptions::AuthenticationError, with: :token_error

    def record_not_found(e)
      render json: { errors: [e.message] }, status: :not_found
      end

    def record_invalid(e)
      render json: e.record.errors.messages, status: 422
      end

    def token_error
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      end
  end
end
