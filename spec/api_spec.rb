require 'helper'


describe ZipMoney::Api do
	
	before :each do
		# Setup the gateway for testing
		
		  Configuration.merchant_id  = 4
	    Configuration.merchant_key = "4mod1Yim1GEv+D5YOCfSDT4aBEUZErQYMJ3EtdOGhQY="
	    Configuration.environment  = 'sandbox'

		@api = ZipMoney.api
	end

  	it "should make settings request" do
     	
      response =  @api.request("settings",:post)
      
      puts response.toObject.Settings.capture_method

  		# puts @api.request("configure")
  		# puts @api.request("quote")
  		# puts @api.request("order")
  		# puts @api.request("cancel")
  		# puts @api.request("refund")
  		# puts @api.request("query")
  		# puts @api.request("checkout")
  		# puts @api.request("heartbeat")

  	end


    it "should make checkout request and return redirect_url" do 

      checkout_json = JSON.parse(File.read("spec/fixtures/checkout.json"))

      response = @api.checkout(checkout_json)

      if response.isSuccess
        puts response.getRedirectUrl
      else
        puts response.getError
      end

    end 


    it "should make quote request and return redirect_url" do 

      checkout_json = JSON.parse(File.read("spec/fixtures/quote.json"))

      response = @api.quote(checkout_json)

      if response.isSuccess
        puts response.getRedirectUrl
      else
        puts response.getError
      end

    end
    

    it "should make capture request and return redirect_url" do 

      checkout_json = JSON.parse(File.read("spec/fixtures/quote.json"))

      response = @api.capture(checkout_json)

      if response
        puts response.getRedirectUrl
      else
        puts response
      end

    end

end	
