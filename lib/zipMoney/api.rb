module ZipMoney
	class Api	

		attr_accessor :options, :config, :payload, :response

		HTTP_METHOD_POST  = :post
		HTTP_METHOD_GET   = :get

		def initialize(conf,opt={})	      	
			if conf.new.class == ZipMoney::Configuration
	        	self.config = conf
	      	else
	        	raise ArgumentError, "Config is not valid"
	      	end
	      	self.options = opt
		end

		def append_api_credentials(data)
			
			is_param_defined(data) do
				data = Struct::ApiCredentials.new
				data.version = Struct::Version.new
			end	

			if data.merchant_id  == nil 
			   data.merchant_id  = self.config.merchant_id
			end
			if data.merchant_key == nil
			   data.merchant_key = self.config.merchant_key
			end
			if data.version.client == nil
			   data.version.client = ZipMoney::Configuration::API_NAME + " Version:" + ZipMoney::Configuration::API_VERSION
			end
			if data.version.platform == nil
			   data.version.platform = ZipMoney::Configuration::API_PLATFORM
			end
			data	
		end	

		def is_param_defined(data)
			yield if !data.is_a?(Struct) 
		end	

		def request(resource, method,  params = nil)
			resource = Resources.get(resource, method, params)

			params   = append_api_credentials(params)

			if method == :post
				payload = prepare_params(params)
			else
				payload = {}
			end

			headers = self.options[:headers] || {}

			if method == :get 
				resource.send(method, headers) do |response, request, result, &block| 
				  	ZipMoney::Response.new(response)
				end
			else
				resource.send(method, payload, headers) do |response, request, result, &block|
					ZipMoney::Response.new(response)
				end
			end
		end
		
		def prepare_params(data)
			begin
			    data =  Util.struct_to_hash(data).to_json
			rescue TypeError => e
			    if data.is_a?(Hash)
			   	   data = data.to_json
			   	else  
	        		raise ArgumentError, "Invalid params provided" 
				end
			rescue JSON::ParserError => e
			    if data.is_a?(Hash)
			   	   data = data.to_json
			   	else  
	        		raise ArgumentError, "Invalid params provided" 
				end
			end
			data
		end	

		def checkout(params)
			request(Resources::RESOURCE_CHECKOUT, HTTP_METHOD_POST, params)
		end	
		
		def quote(params)
			request(Resources::RESOURCE_QUOTE, HTTP_METHOD_POST, params)
		end	
		
		def capture(params)
			request(Resources::RESOURCE_CAPTURE, HTTP_METHOD_POST, params)
		end	
		
		def refund(params)
			request(Resources::RESOURCE_REFUND, HTTP_METHOD_POST, params)
		end	

		def cancel(params)
			request(Resources::RESOURCE_CANCEL, HTTP_METHOD_POST, params)
		end	

		def query(params)
			request(Resources::RESOURCE_QUERY, HTTP_METHOD_POST, params)
		end	

		def configure(params)
			request(Resources::RESOURCE_CONFIGURE, HTTP_METHOD_POST, params)
		end	

		def settings
			request(Resources::RESOURCE_SETTINGS, HTTP_METHOD_POST)
		end	

		def heartbeat
			request(Resources::RESOURCE_HEARTBEAT, HTTP_METHOD_POST)
		end	
	end
end
