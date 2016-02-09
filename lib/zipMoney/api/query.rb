module ZipMoney
	class Query
		include Request
	
		attr_accessor :params

		Struct.new("QueryParams", :orders, :merchant_id, :merchant_key, :version, :metadata)
		Struct.new("QueryOrder", :id, :status, :error_message, :txn_id)
	
		def initialize 
			@params 		 = Struct::RefundParams.new			
			@params.order 	 = Array.new
			@params.metadata = Struct::Metadata.new
			@params.version  = Struct::Version.new
		end
			
		def do	
			raise ArgumentError, "Params emtpy" if params.nil? 
			ZipMoney.api.query(self.params)
		end

		def validate_params
			raise ArgumentError, "Params emtpy" if params.nil? 
			@errors = []
          	@errors << 'order must be provided' if self.params.order.nil? 
          	@errors << 'order.id must be provided' if self.params.order.id.nil? 
          	raise ZipMoney::RequestError.new("Following error(s) occurred while making request, please resolve them to make the request: #{@errors}") if @errors.any?
		end
	end
end
