module ZipMoney
	class Checkout
		include Request
		
		attr_accessor :params

		Struct.new("CheckoutParams", :charge, :currency_code, :return_url, :cancel_url, :notify_url, :error_url, :in_store, :txn_id, :merchant_id, :merchant_key, 
									:order_id, :order, :consumer, :billing_address, :shipping_address, :version, :metadata)
		
		def initialize 
			@params 		= Struct::CheckoutParams.new
			@params.order 	= Struct::Order.new
			@params.billing_address  = Struct::Address.new
			@params.shipping_address = Struct::Address.new
			@params.consumer = Struct::Consumer.new
			@params.metadata = Struct::Metadata.new
			@params.version  = Struct::Version.new

			@params.order.detail =  Array.new
		end
			
		def do	
			validate

			ZipMoney.api.checkout(self.params)
		end

		def validate
			raise ArgumentError, "Params emtpy" if params.nil? 
			@errors = []
          	@errors << 'charge must be provided' if self.params.charge.nil? 
          	@errors << 'currency_code must be provided' if self.params.currency_code.nil? 
          	@errors << 'order_id must be provided' if self.params.order_id.nil? 
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
