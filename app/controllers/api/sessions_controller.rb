module Api
  class SessionsController < ApplicationController
    skip_before_action :authenticate

    def create
      service = ApiLoginManager.new(params)
      token   = service.call

      if token
        render json: { token: token }
      else
        render json: { error: service.error }, status: :bad_request
      end
    end
  end
end
