require 'helper'


describe ZipMoney::WebHook do
  	before :each do
      # Setup the gateway for testing
      ZipMoney::Configuration.merchant_id  = 4
      ZipMoney::Configuration.merchant_key = "4mod1Yim1GEv+D5YOCfSDT4aBEUZErQYMJ3EtdOGhQY="
      ZipMoney::Configuration.environment  = 'sandbox'
      
    end

    it "should listen to requests from api" do
          str = '{
            "Type": "Notification",
            "MessageId": "6c2a13e1-c2e4-56f7-92ca-5f45d84131e9",
            "TopicArn": "...",
            "Subject": "authorise_succeeded",
            "Message": "{\"type\":\"authorise_succeeded\",\"response\":{\"merchant_id\":\"4\",\"merchant_key\":\"4mod1Yim1GEv+D5YOCfSDT4aBEUZErQYMJ3EtdOGhQY=\",\"txn_id\":\"4794\",\"order_id\":\"100001127\",\"create_time\":\"2014-09-30T12:41:47.1909547+10:00\",\"status\":\"Authorised\",\"error_message\":null,\"version\":null,\"metadata\":null}}",
            "Timestamp": "2014-09-30T02:41:41.072Z",
            "SignatureVersion": "1",
            "Signature": "...",
            "SigningCertURL": "https://sns.ap-southeast-2.amazonaws.com/SimpleNotificationService-d6d679a1d18e95c2f9ffcf11f4f9e198.pem",
            "UnsubscribeURL": "..."
          }'


        str = '{
                "Type" : "SubscriptionConfirmation",
                "MessageId" : "84a94b75-b6da-443a-b21d-9f66706e4ff9",
                "Token" : "",
                "TopicArn" : "arn:aws:sns:ap-southeast-2:381371729123:...",
                "Message" : "You have chosen to subscribe to the topic arn:aws:sns:ap-southeast-2:381371729123:...\nTo confirm the subscription, visit the SubscribeURL included in this message.",
                "SubscribeURL1" : "https://sns.ap-southeast-2.amazonaws.com/?Action=ConfirmSubscription&TopicArn=arn:aws:sns:ap-southeast-2:381371729123:...&Token=2336412f37fb687f5d51e6e241d638b056f5982d58cbd9068a973a9da3b0c1f2d5adf25ff9449ffcb67cba92a19c4b540d3ff64729f5caea3d72aeda5f205af013ada3122d4bfc9cc2f0210783e5aa397bd702a7f40c2487929b2e4407cc2936d0680750a9ee88d44748750eac7ecced41a8c29f85baf11ff8a523548696653f171c3bf6d088e23c2e6822141e055061",
                "SubscribeURL" : "http://google.com",
                "Timestamp" : "2014-08-25T08:29:50.224Z",
                "SignatureVersion" : "1",
                "Signature" : "...",
                "SigningCertURL" : "..."
              }'

          ZipMoney.webhook.process str do |type,data|
              puts type
              case type
                  when ZipMoney.webhook::EVENT_AUTH_SUCCESS
                    #do something here 
                  when ZipMoney.webhook::EVENT_AUTH_FAIL
                    #do something here
                  when ZipMoney.webhook::EVENT_AUTH_REVIEW
                    #do something here
                  when ZipMoney.webhook::EVENT_AUTH_DECLINED
                    #do something here
                  when ZipMoney.webhook::EVENT_CANCEL_SUCCESS
                    #do something here
                  when ZipMoney.webhook::EVENT_CANCEL_FAIL
                    #do something here
                  when ZipMoney.webhook::EVENT_CAPTURE_FAIL
                    #do something here
                  when ZipMoney.webhook::EVENT_REFUND_SUCCESS
                    #do something here
                  when ZipMoney.webhook::EVENT_REFUND_FAIL
                    #do something here
                  when ZipMoney.webhook::EVENT_ORDER_CANCELLED
                    #do something here
                  when ZipMoney.webhook::EVENT_CHARGE_SUCCESS
                    #do something here
                  when ZipMoney.webhook::EVENT_CHARGE_FAIL
                    #do something here
                  when ZipMoney.webhook::EVENT_CONFIG_UPDATE
                    #do something here
              end 
          end

    end
end	
