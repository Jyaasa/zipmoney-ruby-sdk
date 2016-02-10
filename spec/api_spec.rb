require 'helper'


describe ZipMoney::Api do
  	
  	before :each do
  		# Setup the gateway for testing
  		ZipMoney::Configuration.merchant_id  = 4
      ZipMoney::Configuration.merchant_key = "4mod1Yim1GEv+D5YOCfSDT4aBEUZErQYMJ3EtdOGhQY="
  	  ZipMoney::Configuration.environment  = 'sandbox'
  	end

  	it "should make settings request" do
     	
      settings = ZipMoney::Settings.new
      response = settings.do()
     
      if response.isSuccess 
        puts response.toObject.Settings
      else
        puts response.getError
      end
  	end


    it "should make checkout request and return redirect_url" do 

      checkout_json = JSON.parse(File.read("spec/fixtures/checkout.json"))

      # Request 
      checkout = ZipMoney::Checkout.new
        
        checkout.params.charge        = checkout_json["charge"]
        checkout.params.currency_code = checkout_json["currency_code"]
        checkout.params.txn_id        = checkout_json["txn_id"]
        checkout.params.return_url    = checkout_json["return_url"]
        checkout.params.cancel_url    = checkout_json["cancel_url"]
        checkout.params.notify_url    = checkout_json["notify_url"]
        checkout.params.error_url     = checkout_json["error_url"]
        checkout.params.in_store      = checkout_json["in_store"]
        checkout.params.order_id      = checkout_json["order_id"]

        checkout.params.order.id              = checkout_json["order"]["id"]
        checkout.params.order.tax             = checkout_json["order"]["tax"]
        checkout.params.order.shipping_value  = checkout_json["order"]["shipping_value"]
        checkout.params.order.total           = checkout_json["order"]["total"]

        checkout.params.order.detail[0] = Struct::Detail.new
        
        item  = checkout_json["order"]["detail"]

        checkout.params.order.detail[0].quantity = item[0]["quantity"]
        checkout.params.order.detail[0].name  = item[0]["name"]
        checkout.params.order.detail[0].price = item[0]["price"]
        checkout.params.order.detail[0].description = item[0]["description"]
        checkout.params.order.detail[0].sku = item[0]["sku"]
        checkout.params.order.detail[0].id  = item[0]["id"]
        checkout.params.order.detail[0].category  = item[0]["category"]
        checkout.params.order.detail[0].image_url = item[0]["image_url"]

        checkout.params.billing_address.first_name = checkout_json["billing_address"]["first_name"]
        checkout.params.billing_address.last_name  = checkout_json["billing_address"]["last_name"]
        checkout.params.billing_address.line1      = checkout_json["billing_address"]["line1"]
        checkout.params.billing_address.line2      = checkout_json["billing_address"]["line2"]
        checkout.params.billing_address.country    = checkout_json["billing_address"]["country"]
        checkout.params.billing_address.zip        = checkout_json["billing_address"]["zip"]
        checkout.params.billing_address.city       = checkout_json["billing_address"]["city"]
        checkout.params.billing_address.state      = checkout_json["billing_address"]["state"]
        
        checkout.params.shipping_address.first_name = checkout_json["shipping_address"]["first_name"]
        checkout.params.shipping_address.last_name  = checkout_json["shipping_address"]["last_name"]
        checkout.params.shipping_address.line1      = checkout_json["shipping_address"]["line1"]
        checkout.params.shipping_address.line2      = checkout_json["shipping_address"]["line2"]
        checkout.params.shipping_address.country    = checkout_json["shipping_address"]["country"]
        checkout.params.shipping_address.zip        = checkout_json["shipping_address"]["zip"]
        checkout.params.shipping_address.city       = checkout_json["shipping_address"]["city"]
        checkout.params.shipping_address.state      = checkout_json["shipping_address"]["state"]

        checkout.params.consumer.first_name = checkout_json["consumer"]["first_name"]
        checkout.params.consumer.last_name  = checkout_json["consumer"]["last_name"]
        checkout.params.consumer.phone      = checkout_json["consumer"]["phone"]
        checkout.params.consumer.gender     = checkout_json["consumer"]["gender"]
        checkout.params.consumer.email      = checkout_json["consumer"]["email"]
        checkout.params.consumer.dob        = checkout_json["consumer"]["dob"]
        checkout.params.consumer.title      = checkout_json["consumer"]["title"]

      response = checkout.do()

      if response.isSuccess
        puts response.getRedirectUrl
      else
        puts response.getError
      end
    end 

    it "should make quote request and return redirect_url" do 

      quote_json = JSON.parse(File.read("spec/fixtures/quote.json"))

      # Request 
      quote = ZipMoney::Quote.new

        quote.params.currency_code = quote_json["currency_code"]
        quote.params.txn_id        = quote_json["txn_id"]
        quote.params.cart_url      = quote_json["cart_url"]
        quote.params.success_url   = quote_json["success_url"]
        quote.params.cancel_url    = quote_json["cancel_url"]
        quote.params.error_url     = quote_json["error_url"]
        quote.params.refer_url     = quote_json["refer_url"]
        quote.params.decline_url   = quote_json["decline_url"]
        quote.params.in_store      = quote_json["in_store"]
        quote.params.quote_id      = quote_json["quote_id"]
        quote.params.checkout_source = quote_json["checkout_source"]

        quote.params.order.id              = quote_json["order"]["id"]
        quote.params.order.tax             = quote_json["order"]["tax"]
        quote.params.order.shipping_value  = quote_json["order"]["shipping_value"]
        quote.params.order.total           = quote_json["order"]["total"]

        quote.params.order.detail[0] = Struct::Detail.new
        
        item = quote_json["order"]["detail"]

        quote.params.order.detail[0].quantity = item[0]["quantity"]
        quote.params.order.detail[0].name  = item[0]["name"]
        quote.params.order.detail[0].price = item[0]["price"]
        quote.params.order.detail[0].description = item[0]["description"]
        quote.params.order.detail[0].sku = item[0]["sku"]
        quote.params.order.detail[0].id  = item[0]["id"]
        quote.params.order.detail[0].category  = item[0]["category"]
        quote.params.order.detail[0].image_url = item[0]["image_url"]

        quote.params.billing_address.first_name = quote_json["billing_address"]["first_name"]
        quote.params.billing_address.last_name  = quote_json["billing_address"]["last_name"]
        quote.params.billing_address.line1      = quote_json["billing_address"]["line1"]
        quote.params.billing_address.line2      = quote_json["billing_address"]["line2"]
        quote.params.billing_address.country    = quote_json["billing_address"]["country"]
        quote.params.billing_address.zip        = quote_json["billing_address"]["zip"]
        quote.params.billing_address.city       = quote_json["billing_address"]["city"]
        quote.params.billing_address.state      = quote_json["billing_address"]["state"]
        
        quote.params.shipping_address.first_name = quote_json["shipping_address"]["first_name"]
        quote.params.shipping_address.last_name  = quote_json["shipping_address"]["last_name"]
        quote.params.shipping_address.line1      = quote_json["shipping_address"]["line1"]
        quote.params.shipping_address.line2      = quote_json["shipping_address"]["line2"]
        quote.params.shipping_address.country    = quote_json["shipping_address"]["country"]
        quote.params.shipping_address.zip        = quote_json["shipping_address"]["zip"]
        quote.params.shipping_address.city       = quote_json["shipping_address"]["city"]
        quote.params.shipping_address.state      = quote_json["shipping_address"]["state"]

        quote.params.consumer.first_name = quote_json["consumer"]["first_name"]
        quote.params.consumer.last_name  = quote_json["consumer"]["last_name"]
        quote.params.consumer.phone      = quote_json["consumer"]["phone"]
        quote.params.consumer.gender     = quote_json["consumer"]["gender"]
        quote.params.consumer.email      = quote_json["consumer"]["email"]
        quote.params.consumer.dob        = quote_json["consumer"]["dob"]
        quote.params.consumer.title      = quote_json["consumer"]["title"]

      response = quote.do()

      if response.isSuccess
        puts response.getRedirectUrl
      else
        puts response.getError
      end
    end 
end	
