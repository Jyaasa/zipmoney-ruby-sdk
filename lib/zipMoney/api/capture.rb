module ZipMoney
  class Capture
    include Request

    attr_accessor :params

    Struct.new("CaptureParams",  :txn_id, :order_id, :quote_id, :order, :reference, :version, :metadata, :merchant_id, :merchant_key)
    
    # Initializes a ZipMoney::Capture object
    #
    # Returns ZipMoney::Capture object
      def initialize 
      @params      = Struct::CaptureParams.new
      @params.order    = Struct::Order.new
      @params.metadata = Struct::Metadata.new
      @params.version  = Struct::Version.new
      @params.order.detail = Array.new
    end
    
    # Performs the Capture api call on zipMoney endpoint
    #
    # Returns ZipMoney::Cancel object 
    def do  
      validate
      ZipMoney.api.capture(self.params)
    end

    # Performs the parameters validation
    def validate
      raise ArgumentError, "Params emtpy" if params.nil? 
      @errors = []
      @errors << 'txn_id must be provided' if self.params.txn_id.nil? 
      @errors << 'order.id must be provided' if self.params.order.id.nil? 
      @errors << 'order.total must be provided' if self.params.order.total.nil? 
      @errors << 'order.shipping_value must be provided' if self.params.order.shipping_value.nil? 
      @errors << 'order.tax must be provided' if self.params.order.tax.nil? 
      @errors << 'order detail must be provided' if self.params.order.detail.nil? 
      raise ZipMoney::RequestError.new("Following error(s) occurred while making request, please resolve them to make the request: #{@errors}") if @errors.any?
    end
  end
end
