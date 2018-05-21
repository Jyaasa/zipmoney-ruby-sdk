require 'spec_helper'


describe ZipMoney::Express do
  	before :each do
      # Setup the gateway for testing
      ZipMoney::Configuration.merchant_id  = "86"
      ZipMoney::Configuration.merchant_key = "QCXlS0BOrFl+hkd2fbSR7ujEuDP4WZECYw4oB0il5eE="
      ZipMoney::Configuration.environment  = 'sandbox'
         
    end

    # it "should listen to requests from api" do
    #       sample_request = JSON.parse(File.read("spec/fixtures/checkout.json"))

    #       sample_request["merchant_id"]   = ZipMoney::Configuration.merchant_id
    #       sample_request["merchant_key"]  = ZipMoney::Configuration.merchant_key

    #       # Process quotedetails Action   
    #       # http://merchant-url/zipmoneypayment/quotedetails
    #       ZipMoney.express.process(ZipMoney::Express::ACTION_GET_QUOTE_DETAILS, sample_request) do |t,request|
    #         {"type" => t}
    #       end  

    #       # Process shippingmethods Action  
    #       # http://merchant-url/zipmoneypayment/shippingmethods
    #       ZipMoney.express.process(ZipMoney::Express::ACTION_GET_SHIPPING_METHODS, sample_request) do |t,request|
    #         {"type" => t}
    #       end 

    #       # Process confirmshippingmethod Action
    #       # http://merchant-url/zipmoneypayment/confirmshippingmethod
    #       ZipMoney.express.process(ZipMoney::Express::ACTION_CONFIRM_SHIPPING_METHOD, sample_request) do |t,request|
    #         {"type" => t}
    #       end
          
    #       # Process confirmorder Action
    #       # http://merchant-url/zipmoneypayment/confirmorder
    #       ZipMoney.express.process(ZipMoney::Express::ACTION_CONFIRM_ORDER, sample_request) do |t,request|
    #         {"type" => t}
    #       end
    
    #       # Process finaliseorder Action
    #       # http://merchant-url/zipmoneypayment/finaliseorder
    #       ZipMoney.express.process(ZipMoney::Express::ACTION_FINALISE_ORDER, sample_request) do |t,request|
    #         {"type" => t}
    #       end

    #       # Process cancelquote Action
    #       # http://merchant-url/zipmoneypayment/cancelquote
    #       ZipMoney.express.process(ZipMoney::Express::ACTION_CANCEL_QUOTE, sample_request) do |t,request|
    #         {"type" => t}
    #       end
    # end
end	
