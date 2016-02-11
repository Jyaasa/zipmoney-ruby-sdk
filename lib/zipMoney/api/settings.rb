module ZipMoney
  class Settings
    include Request

    attr_accessor :params

    Struct.new("SettingsParams", :merchant_id, :merchant_key, :version, :metadata)
    
    # Performs the Checkout api call on zipMoney endpoint
    #
    # Returns ZipMoney::Checkout object 
    def do  
      ZipMoney.api.settings()
    end
  end
end
