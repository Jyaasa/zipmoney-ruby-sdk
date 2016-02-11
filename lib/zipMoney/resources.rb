module ZipMoney
	class Resources
		
		RESOURCE_SETTINGS                 = 'settings'
	    RESOURCE_CONFIGURE                = 'configure'
	    RESOURCE_QUOTE                    = 'quote'
	    RESOURCE_CANCEL             	  = 'cancel'
	    RESOURCE_REFUND             	  = 'refund'
	    RESOURCE_CHECKOUT                 = 'checkout'
	    RESOURCE_QUERY                    = 'query'
	    RESOURCE_CAPTURE                  = 'capture'
	    RESOURCE_HEART_BEAT               = 'Heartbeat'

	    class << self
			# Checks if passed resource is valid and returns RestClient::Resource object 
			# configured with the passed resource and url
			#
			# @param [resource] endpoint resource 
			# @param [method] method  get|post
			# @param [query_string] query_string parameters
			#
			# @return RestClient::Resource object
			def get(resource, method = :post, query_string = nil)
				return false unless resource_exists(resource)
				
				url = get_url(resource, (method == :get ? query_string : nil))
				ssl_opts = {:verify_ssl => OpenSSL::SSL::VERIFY_PEER}
	  			opts = {}
    			RestClient::Resource.new(url, opts.merge(ssl_opts))
	    	end	

	    	# Checks if passed resource exists 
			#
			# @param [resource] endpoint resource 
			#
			# @return ZipMoney::Response object
	    	def resource_exists(resource)
	    		if resource.is_a?(String)
	    			if(self.constants.map{ |k| self.const_get(k).downcase }.include?resource)
	    		   		resource
	    			end  
	    		else
	    			raise ArgumentError, "#{resource} should be a string"
	    		end
	    	end
	    		
	    	# Builds the proper endpoint url with the given resource
			#
			# @param [resource] endpoint resource 
			# @param [query_string] query_string parameters
			#
			# @return String
	    	def get_url(resource, query_string = nil)
				if Configuration.is_sandbox
					url = "#{Configuration::ENV_TEST_API_URL}"
				else
					url = "#{Configuration::ENV_LIVE_API_URL}"
				end		

				url = 	url + resource

				unless query_string.nil?
					url = url + "?" + 
					query_string.map do |key, value|
						"#{key}=#{value}" 
					end.join("&")
				end
				url
			end
	    end
	end
end
