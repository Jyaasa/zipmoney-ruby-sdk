module ZipMoney
  class Cancel
    include Request

    attr_accessor :params
    Struct.new("CancelParams", :txn_id, :merchant_id, :merchant_key, :order, :order_id, :quote_id, :reference, :version, :metadata)

    # Initializes a ZipMoney::Cancel object
    #
    # Returns ZipMoney::Cancel object
    def initialize 
      @params      = Struct::CancelParams.new
      @params.order    = Struct::Order.new
      @params.order.detail =  Array.new
      @params.metadata = Struct::Metadata.new
      @params.version  = Struct::Version.new
    end
    
    # Performs the Cancel api call on zipMoney endpoint
    #
    # Returns ZipMoney::Cancel object 
    def do  
      validate
      ZipMoney.api.cancel(self.params)
    end

    # Performs the parameters validation
    def validate
      raise ArgumentError, "Params emtpy" if params.nil? 
      @errors = []
      @errors << 'txn_id must be provided' if self.params.txn_id.nil? 
      @errors << 'order must be provided' if self.params.order.nil? 
      @errors << 'order.id must be provided' if self.params.order.id.nil? 
      @errors << 'order.total must be provided' if self.params.order.total.nil? 
      @errors << 'order.shipping_value must be provided' if self.params.order.shipping_value.nil? 
      @errors << 'order.tax must be provided' if self.params.order.tax.nil? 
      @errors << 'order detail must be provided' if self.params.order.detail.nil? 
      raise ZipMoney::RequestError.new("Following error(s) occurred while making request, please resolve them to make the request: #{@errors}") if @errors.any?
    end
  end
end
