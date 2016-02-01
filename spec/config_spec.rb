require 'helper'


describe ZipMoney::Configuration do
  it "should configure" do
    
    ZipMoney::Configuration.merchant_id  = 1
    ZipMoney::Configuration.merchant_key = 2
    ZipMoney::Configuration.environment  = 'sandbox'

    #puts ZipMoney::Configuration.merchant_id
    #ZipMoney::Configuration.merchant_key == 2 
    #ZipMoney::Configuration.environment

  end
end	