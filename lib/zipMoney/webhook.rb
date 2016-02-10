module ZipMoney
	module WebHook
		attr_accessor :merchant_id, :merchant_key

		EVENT_AUTH_SUCCESS    = "authorise_succeeded"
	    EVENT_AUTH_FAIL       = "authorise_failed"
	    EVENT_AUTH_REVIEW     = "authorise_under_review"
	    EVENT_AUTH_DECLINED   = "authorise_declined"
	    EVENT_CANCEL_SUCCESS  = "cancel_succeeded"
	    EVENT_CANCEL_FAIL     = "cancel_failed"
	    EVENT_CAPTURE_SUCCESS = "capture_succeeded"
	    EVENT_CAPTURE_FAIL    = "capture_failed"
	    EVENT_REFUND_SUCCESS  = "refund_succeeded"
	    EVENT_REFUND_FAIL     = "refund_failed"
	    EVENT_ORDER_CANCELLED = "order_cancelled"
	    EVENT_CHARGE_SUCCESS  = "charge_succeeded"
	    EVENT_CHARGE_FAIL     = "charge_failed"
	    EVENT_CONFIG_UPDATE   = "configuration_updated"

	    TYPE_SUBSCRIPTION_CONFIRMATION = "SubscriptionConfirmation"
	    TYPE_NOTIFICATION 		  	   = "Notification"

	    def self.process(payload,&block)
			raise WebHookRequestError, "Payload emtpy" if payload.nil? 
			data = Util.json_parse(payload)
			if data["Type"] == TYPE_SUBSCRIPTION_CONFIRMATION
    			subscribe(data["SubscribeURL"])
    		elsif data["Type"] == TYPE_NOTIFICATION	
    			process_notifications(data, &block)
    		end	
    	end

    	def self.process_notifications(data, &block)
    		raise ArgumentError, "Invalid params provided" if data["Message"].nil?
    		message = Util.json_parse(data["Message"])
    		Util.credentials_valid(message["response"]["merchant_id"], message["response"]["merchant_key"])
    		raise ArgumentError, "Response empty" if message["response"].nil?
    		
    		if (block.arity > 0)
       			block.call(message['type'], message["response"])
    		end	
    	end

    	def self.subscribe(url)			
    		raise WebHookError, "Url emtpy" if url.nil? 
    		RestClient.get(url)
    	end	
	end
end



