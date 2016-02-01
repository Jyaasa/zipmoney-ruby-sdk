module ZipMoney
	class Configuration
		
		API_VERSION 	 = "1"

	    ENV_LIVE_API_URL = "https://api.zipmoney.com.au/v1/"
	    ENV_TEST_API_URL = "https://api.sandbox.zipmoney.com.au/v1/"
	
	    ATTRIBUTES = [
	      :merchant_id,
	      :merchant_key,
	      :environment,
	    ]

    	attr_accessor *ATTRIBUTES

	    class << self
	      	attr_accessor *ATTRIBUTES

	      	def environment=(env)
		      	env = env.to_sym
		      	unless [:sandbox, :live].include?(env)
		        	raise ArgumentError, "#{env.inspect} is not a valid environment"
		      	end
		      @environment = env
	    	end

	    	def is_sandbox
	    		environment.to_s == "sandbox"
	   		end
	    end
	
	end
end
