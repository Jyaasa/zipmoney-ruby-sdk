module ZipMoney
  class Refund
    include Request

    attr_accessor :params

    Struct.new("RefundParams", :reason, :refund_amount, :txn_id, :order_id, :quote_id, :order, :reference, :version, :metadata, :merchant_id, :merchant_key)
    
    # Initializes a ZipMoney::Refund object
    #
    # Returns ZipMoney::Refund object
    def initialize 
      @params      = Struct::RefundParams.new
      @params.order    = Struct::Order.new
      @params.metadata = Struct::Metadata.new
      @params.version  = Struct::Version.new
      @params.order.detail = Array.new
    end
    
    # Performs the Refund api call on zipMoney endpoint
    #
    # Returns ZipMoney::Refund object 
    def do  
      validate
      ZipMoney.api.refund(@params)
    end
    
    # Performs the parameters validation
    def validate
      raise ArgumentError, "Params emtpy" if @params.nil? 
      @errors = []
      @errors << 'reason must be provided' if @params.reason.nil? 
      @errors << 'refund_amount must be provided' if @params.refund_amount.nil? 
      @errors << 'txn_id must be provided' if @params.txn_id.nil? 
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
