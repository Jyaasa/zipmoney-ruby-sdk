
require 'json'
require 'rest_client'


require_relative "zipMoney/version"
require_relative "zipMoney/configuration"
require_relative "zipMoney/errors"
require_relative "zipMoney/resources"
require_relative "zipMoney/api"
require_relative "zipMoney/response"

module ZipMoney
    extend self

    attr_accessor :config, :_api

    def api

      self.config = Configuration	

      configure_api
  
      raise ApiError.new("Please configure the Api first") if self.config.nil?

   	  self._api

    end

    def configure_api
    
      options = {:headers => {:content_type => :json}}

      self._api = Api.new(self.config,options)
    end

end
