module ZipMoney
	class Query
		include Request
	
		attr_accessor :params

		Struct.new("QueryParams", :orders, :merchant_id, :merchant_key, :version, :metadata)
		Struct.new("QueryOrder", :id, :status, :error_message, :txn_id)
		
		# Initializes a ZipMoney::Query object
        #
        # Returns ZipMoney::Query object
		def initialize 
			@params 		 = Struct::QueryParams.new			
			@params.orders 	 = Array.new
			@params.metadata = Struct::Metadata.new
			@params.version  = Struct::Version.new
		end
		
		# Performs the Query api call on zipMoney endpoint
        #
        # Returns ZipMoney::Query object	
		def do	
			validate
			ZipMoney.api.query(self.params)
		end

		# Performs the parameters validation
		def validate
			raise ArgumentError, "Params emtpy" if params.nil? 
			@errors = []
          	@errors << 'at least one order must be provided' if self.params.orders.nil? 
          	raise ZipMoney::RequestError.new("Following error(s) occurred while making request, please resolve them to make the request: #{@errors}") if @errors.any?
		end
	end
end
