module ZipMoney
  class Quote
    include Request

    attr_accessor :params

    Struct.new("QuoteParams", :currency_code, :cart_url, :success_url, :cancel_url, :refer_url, :error_url, :decline_url, :in_store, :checkout_source, :txn_id, :merchant_id, :merchant_key, 
                  :quote_id, :order, :consumer, :billing_address, :shipping_address, :version, :metadata, :token)
    
    # Initializes a ZipMoney::Quote object
    #
    # Returns ZipMoney::Quote object
    def initialize 
      @params     = Struct::QuoteParams.new
      @params.order   = Struct::Order.new
      @params.billing_address  = Struct::Address.new
      @params.shipping_address = Struct::Address.new
      @params.consumer = Struct::Consumer.new
      @params.metadata = Struct::Metadata.new
      @params.version  = Struct::Version.new
      @params.order.detail = Array.new
    end
    
    # Performs the Quote api call on zipMoney endpoint
    #
    # Returns ZipMoney::Quote object  
    def do  
      validate
      ZipMoney.api.quote(@params)
    end
    
    # Performs the parameters validation
    def validate
      raise ArgumentError, "Params emtpy" if @params.nil? 
      @errors = []
      @errors << 'quote_id must be provided' if @params.quote_id.nil? 
      @errors << 'success_url must be provided' if @params.success_url.nil? 
      @errors << 'cancel_url must be provided' if @params.cancel_url.nil? 
      @errors << 'error_url must be provided' if @params.error_url.nil? 
      @errors << 'decline_url must be provided' if @params.decline_url.nil? 
      @errors << 'quote_id must be provided' if @params.quote_id.nil? 
      @errors << 'order must be provided' if @params.order.nil? 
      @errors << 'order.id must be provided' if @params.order.id.nil? 
      @errors << 'order.total must be provided' if @params.order.total.nil? 
      @errors << 'order.shipping_value must be provided' if @params.order.shipping_value.nil? 
      @errors << 'order.tax must be provided' if @params.order.tax.nil? 
      @errors << 'order detail must be provided' if @params.order.detail.nil? 

      validate_item_details @params.order.detail

      raise ZipMoney::RequestError.new("Following error(s) occurred while making request, please resolve them to make the request: #{@errors}") if @errors.any?
    end
  end
end
