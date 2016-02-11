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

    # Process the webhook
    #
    # @param [request] WebHook's request 
    # @param [block] Actions to be taken for respective notifications
    def self.process(request,&block)
		raise WebHookRequestError, "Payload emtpy" if request.nil? 
		request = Util.json_parse(request)
		if request["Type"] == TYPE_SUBSCRIPTION_CONFIRMATION
  			subscribe(request["SubscribeURL"])
  		elsif request["Type"] == TYPE_NOTIFICATION	
  			process_notifications(request, &block)
  		end	
  	end
        
    # Process the webhook notifications
    #
    # @param [request] WebHook's request 
    # @param [block] Actions to be taken for respective notifications
  	def self.process_notifications(request, &block)
  		raise ArgumentError, "Invalid params provided" if request["Message"].nil?
  		message = Util.json_parse(request["Message"])
  		Configuration.credentials_valid(message["response"]["merchant_id"], message["response"]["merchant_key"])
  		raise ArgumentError, "Response empty" if message["response"].nil?
  		
  		if (block.arity > 0)
     		block.call(message['type'], message["response"])
  		end	
  	end

    # Subscribes for the webhook notifications by calling the subscription url
    #
    # @param [request] WebHook's request 
    # @param [block] Actions to be taken for respective notifications
  	def self.subscribe(url)			
  		raise WebHookError, "Url emtpy" if url.nil? 
  		
  		begin
  			response = RestClient.get(url)
  		rescue
  			raise WebHookError, "Unable to reach the subscription url #{url}" if response.nil?
  		end	
        response.code == 200 || response.code == 201
  	end	
	end
end