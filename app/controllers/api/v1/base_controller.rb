module Api::V1
  class BaseController < ApplicationController
    include Authentication
    include Responder
  end
end
