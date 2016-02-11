
require 'json'
require 'rest_client'

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
    
    # Return the api instance
    def api
      @config = ZipMoney::Configuration
      configure_api if @_api.nil?
   	  @_api
    end

    # Configure the api
    def configure_api
      options = {:headers => {:content_type => :json}}
      @_api = ZipMoney::Api.new(@config,options)
    end
    
    # Return the webhook class
    def webhook
      @config   = ZipMoney::Configuration  
      @_webhook = ZipMoney::WebHook if @_webhook.nil?
      @_webhook
    end
    
    # Return the express api class
    def express
      @config   = ZipMoney::Configuration
      @_express = ZipMoney::Express if @_express.nil?
      @_express
    end
end