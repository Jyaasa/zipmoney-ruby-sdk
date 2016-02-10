module ZipMoney
	module Express
		attr_accessor :merchant_id, :merchant_key

		   
	    ACTION_GET_QUOTE_DETAILS        = 'quotedetails';
	    ACTION_GET_SHIPPING_METHODS     = 'shippingmethods';
	    ACTION_CONFIRM_SHIPPING_METHOD  = 'confirmshippingmethod';
	    ACTION_CONFIRM_ORDER            = 'confirmorder';
	    ACTION_FINALISE_ORDER           = 'finaliseorder';
	    ACTION_CANCEL_QUOTE             = 'cancelquote';

	    def self.process(type,request,&block)
			raise ExpressRequestError, "Request emtpy" if request.nil? 
    		process_actions(type, request, &block)
    	end
    
    	def self.process_actions(type,request, &block)
    		raise ExpressRequestError, "Request empty" if request.nil? || type.nil?
    		request = Util.json_parse(request)
    		Util.credentials_valid(request["merchant_id"], request["merchant_key"])
    		if (block.arity > 0)
       			response = block.call(type, request)
       			raise ExpressResponseError, "No response provided" if response.nil?
       			send_response(response)
    		end	
    	end

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

		def self.prepare_response(response)
			response = Util.json_parse(response)
			append_api_credentials(response)
		end	

		def self.send_response(response)
			puts prepare_response(response).to_json
		end	
	end
end



