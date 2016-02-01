module ZipMoney
	class Api	

		DEFAULT_OPTIONS = {:version => Configuration::API_VERSION}

		attr_accessor :options , :config, :payload

		HTTP_METHOD_POST  = :post
		
		HTTP_METHOD_GET   = :post


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
				payload = prepare_params(params)
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
		
		def prepare_params(data)
			
			begin
			  
			   JSON.parse(data)

			rescue JSON::ParserError => e
			    
			    if data.is_a?(Hash)
			   	   data = data.to_json
			   	else  
	        		raise ArgumentError, "Invalid params provided" 
				end

			end
				
			data
		end	

		def  checkout(params)

	        raise ArgumentError, "Params not provided" if params.nil? || params.empty?

			response = @api.request(Resources::RESOURCE_CHECKOUT, self::HTTP_METHOD_POST, params)

			if response.isSuccess
				response
			else
				response.getError
			end

		end	
		
		def  quote(params)

	        raise ArgumentError, "Params not provided" if params.nil? || params.empty?

			response = @api.request(Resources::RESOURCE_QUOTE, self::HTTP_METHOD_POST, params)

			if response.isSuccess
				response
			else
				response.getError
			end

		end	
		
		def  capture(params)

	        raise ArgumentError, "Params not provided" if params.nil? || params.empty?

			response = @api.request(Resources::RESOURCE_QUOTE, self::HTTP_METHOD_POST, params)

			if response.isSuccess
				response
			else
				response.getError
			end

		end	
		
		def  refund(params)

	        raise ArgumentError, "Params not provided" if params.nil? || params.empty?

			response = @api.request(Resources::RESOURCE_QUOTE, self::HTTP_METHOD_POST, params)

			if response.isSuccess
				response
			else
				response.getError
			end

		end	

		def  cancel(params)

	        raise ArgumentError, "Params not provided" if params.nil? || params.empty?

			response = @api.request(Resources::RESOURCE_QUOTE, self::HTTP_METHOD_POST, params)

			if response.isSuccess
				response
			else
				response.getError
			end

		end	

		def  query(params)

	        raise ArgumentError, "Params not provided" if params.nil? || params.empty?

			response = @api.request(Resources::RESOURCE_QUOTE, self::HTTP_METHOD_POST, params)

			if response.isSuccess
				response
			else
				response.getError
			end

		end	

		def  configure(params)

	        raise ArgumentError, "Params not provided" if params.nil? || params.empty?

			response = @api.request(Resources::RESOURCE_QUOTE, self::HTTP_METHOD_POST, params)

			if response.isSuccess
				response
			else
				response.getError
			end

		end	

		def  settings

			response = @api.request(Resources::RESOURCE_QUOTE, self::HTTP_METHOD_POST)

			if response.isSuccess
				response
			else
				response.getError
			end

		end	


		def  heartbeat()


			response = @api.request(Resources::RESOURCE_QUOTE, self::HTTP_METHOD_POST)

			if response.isSuccess
				response
			else
				response.getError
			end

		end	




	end
end
