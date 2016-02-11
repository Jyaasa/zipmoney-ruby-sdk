module ZipMoney
	module Express
		attr_accessor :merchant_id, :merchant_key
		   
	    ACTION_GET_QUOTE_DETAILS        = 'quotedetails';
	    ACTION_GET_SHIPPING_METHODS     = 'shippingmethods';
	    ACTION_CONFIRM_SHIPPING_METHOD  = 'confirmshippingmethod';
	    ACTION_CONFIRM_ORDER            = 'confirmorder';
	    ACTION_FINALISE_ORDER           = 'finaliseorder';
	    ACTION_CANCEL_QUOTE             = 'cancelquote';

	    # Process the express checkout action
        #
        # @param [action] Action
        # @param [request] Express checkout request 
        # @param [block] Actions to be taken for respective actions
        #
        # Returns the response to the zipMoney Express Api
	    def self.process(action, request, &block)
    		raise ExpressRequestError, "Action empty" if action.nil?    		
    		raise ExpressRequestError, "Request empty" if request.nil?
    		request = Util.json_parse(request)
    		Configuration.credentials_valid(request["merchant_id"], request["merchant_key"])
    		if (block.arity > 0)
       			response = block.call(action, request)
       			raise ExpressResponseError, "No response provided" if response.nil?
       			puts send_response(response)
    		end	
    	end
 		
 		# Appends api credentials to the express checkout response
        #
        # @param [response] response
        #
		def self.append_api_credentials(response)
			response = Hash.new if !response.is_a?(Hash)

			if response["merchant_id"]  == nil 
			   response["merchant_id"]  = Configuration.merchant_id
			end

			if response["merchant_key"] == nil
			   response["merchant_key"] = Configuration.merchant_key
			end
			response	
		end

		# Prepars the express checkout response
        #
        # @param [response] response
        #
		def self.prepare_response(response)
			response = Util.json_parse(response)
			append_api_credentials(response)
		end	

		# Prints the express checkout response
        #
        # @param [response] response
        #
		def self.send_response(response)
			prepare_response(response).to_json
		end	
	end
end



