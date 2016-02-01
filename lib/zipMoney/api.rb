module ZipMoney
	class Api	

		DEFAULT_OPTIONS = {:version => Configuration::API_VERSION}

		attr_accessor :options , :config, :payload

		def initialize(conf,opt={})	      	
			
			if conf.new.class == ZipMoney::Configuration
	        	self.config = conf
	      	else
	        	raise ArgumentError, "config is an invalid type"
	      	end
	      	self.options = DEFAULT_OPTIONS.merge(opt)


		end

		def append_api_credentials(data)

			data = Hash.new if !data.is_a?(Hash)

			if data[:merchant_id]  == nil
			   data[:merchant_id]  = self.config.merchant_id
			end

			if data[:merchant_key] == nil
			   data[:merchant_key] = self.config.merchant_key
			end

			data	
		end	

		def request(resource, method,  data = nil)
			resource = Resources.get(resource, method, data)

			data = append_api_credentials(data)

			if method == :post
				payload = data.to_json
			else
				payload = {}
			end

			headers = self.options[:headers] || {}

			if method == :get
				resource.send(method, headers) do |response, request, result, &block| 
				    Response.new(response)
				end
			else
				resource.send(method, payload, headers) do |response, request, result, &block|
					Response.new(response)
				end
			end
		end
		
	 
	end
end
