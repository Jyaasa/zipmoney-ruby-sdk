require 'helper'


describe ZipMoney::Api do
	
	before :each do
		# Setup the gateway for testing
		
		  ZipMoney::Configuration.merchant_id  = 4
	    ZipMoney::Configuration.merchant_key = "4mod1Yim1GEv+D5YOCfSDT4aBEUZErQYMJ3EtdOGhQY="
	    ZipMoney::Configuration.environment  = 'sandbox'

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

      response = @api.request("checkout",:post,checkout_json)

      puts response.getRedirectUrl
    end

end	
