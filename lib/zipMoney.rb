
require 'json'
require 'rest_client'

require_relative "zipMoney/version"
require_relative "zipMoney/configuration"
require_relative "zipMoney/errors"
require_relative "zipMoney/util"
require_relative "zipMoney/resources"
require_relative "zipMoney/request"
require_relative "zipMoney/response"
require_relative "zipMoney/api"
require_relative "zipMoney/webhook"
require_relative "zipMoney/express"
require_relative "zipMoney/api/checkout"
require_relative "zipMoney/api/quote"
require_relative "zipMoney/api/capture"
require_relative "zipMoney/api/refund"
require_relative "zipMoney/api/query"
require_relative "zipMoney/api/cancel"
require_relative "zipMoney/api/settings"
require_relative "zipMoney/api/configure"

module ZipMoney
    extend self

    attr_accessor :config, :_api, :_webhook, :_express

    def api
      self.config = Configuration	
      configure_api
      raise ZipMoney::ApiError.new("Please configure the api first") if self._api.nil?
   	  self._api
    end

    def configure_api
      options = {:headers => {:content_type => :json}}
      self._api = ZipMoney::Api.new(self.config,options)
    end

    def webhook
      self.config = Configuration  
      configure_webhook
      raise ZipMoney::ApiError.new("Please configure the webhook first") if self._webhook.nil?
      self._webhook
    end

    def configure_webhook
      self._webhook = ZipMoney::WebHook
    end 

    def express
      self.config = Configuration  
      configure_express
      raise ZipMoney::ApiError.new("Please configure the express api first") if self._express.nil?
      self._express
    end

    def configure_express
      self._express = ZipMoney::Express
    end
end
