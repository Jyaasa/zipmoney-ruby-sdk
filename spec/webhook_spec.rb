require 'spec_helper'


describe ZipMoney::WebHook do
  	before :each do
      # Setup the gateway for testing
      ZipMoney::Configuration.merchant_id  = 86
      ZipMoney::Configuration.merchant_key = "QCXlS0BOrFl+hkd2fbSR7ujEuDP4WZECYw4oB0il5eE="
      ZipMoney::Configuration.environment  = 'sandbox'
      
    end

    it "should listen to webhook request and perform subscription confirmation" do
      subscription_confirmation = JSON.parse(File.read("spec/fixtures/webhooks/subscription_confirmation.json"))
      ZipMoney.webhook.process(subscription_confirmation).should be_truthy
    end 

    it "should listen to webhook request and perform authorise succeeded operations " do
      authorise_succeed = JSON.parse(File.read("spec/fixtures/webhooks/authorise_succeed.json"))
      ZipMoney.webhook.process authorise_succeed do |type,data|
        ZipMoney::WebHook.constants.map{ |k| ZipMoney::WebHook.const_get(k).downcase }.should include(type)
      end
    end  

    it "should listen to webhook request and perform authorise failed operations " do
      authorise_failed = JSON.parse(File.read("spec/fixtures/webhooks/authorise_failed.json"))
      ZipMoney.webhook.process authorise_failed do |type,data|
        ZipMoney::WebHook.constants.map{ |k| ZipMoney::WebHook.const_get(k).downcase }.should include(type)
      end
    end  

    it "should listen to webhook request and cancel failed operations " do
      cancel_failed = JSON.parse(File.read("spec/fixtures/webhooks/cancel_failed.json"))
      ZipMoney.webhook.process cancel_failed do |type,data|
        ZipMoney::WebHook.constants.map{ |k| ZipMoney::WebHook.const_get(k).downcase }.should include(type)
      end
    end   

    it "should listen to webhook request and capture failed operations " do
      capture_failed = JSON.parse(File.read("spec/fixtures/webhooks/capture_failed.json"))
      ZipMoney.webhook.process capture_failed do |type,data|
        ZipMoney::WebHook.constants.map{ |k| ZipMoney::WebHook.const_get(k).downcase }.should include(type)
      end
    end 

    it "should listen to webhook request and refund failed operations " do
      refund_failed = JSON.parse(File.read("spec/fixtures/webhooks/refund_failed.json"))
      ZipMoney.webhook.process refund_failed do |type,data|
        ZipMoney::WebHook.constants.map{ |k| ZipMoney::WebHook.const_get(k).downcase }.should include(type)
      end
    end  
end