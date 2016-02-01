module ZipMoney
	class Resources
		
		RESOURCE_SETTINGS                         = 'settings'
	    RESOURCE_CONFIGURE                        = 'configure'
	    RESOURCE_QUOTE                            = 'quote'
	    RESOURCE_ORDER_SHIPPING_ADDRESS           = 'order'
	    RESOURCE_ORDER_CANCEL                     = 'cancel'
	    RESOURCE_ORDER_REFUND                     = 'refund'
	    RESOURCE_CHECKOUT                         = 'checkout'
	    RESOURCE_QUERY                            = 'query'
	    RESOURCE_CAPTURE                          = 'capture'
	    RESOURCE_HEART_BEAT                       = 'Heartbeat'


	    class << self
			

			def get(resource, method = :post, get_params = nil)

				return false unless self.resource_exists(resource)

				url = get_url(resource, (method == :get ? get_params : nil))

				ssl_opts = {:verify_ssl => OpenSSL::SSL::VERIFY_PEER}

	  			opts = {}

    			RestClient::Resource.new(url, opts.merge(ssl_opts))
	    	end	

	    	def resource_exists(resource)
	    		
	    		if resource.is_a?(String)
	    			if(self.constants.map{ |k| self.const_get(k).downcase }.include?resource)
	    		   		resource
	    			end  
	    		else
	    			raise ArgumentError, "#{resource} should be a string"
	    		end

	    	end
	    		
	    	
	    	def get_url(resource, get_params = nil)
				

				if Configuration.is_sandbox
					url = "#{Configuration::ENV_TEST_API_URL}"
				else
					url = "#{Configuration::ENV_LIVE_API_URL}"
				end		

				url = 	url + resource

				unless get_params.nil?
					url = url + "?" + 
					get_params.map do |key, value|
						"#{key}=#{value}" 
					end.join("&")
				end

				url
			end

	    end
	end
end
