module ZipMoney
	class Configure
		include Request

		attr_accessor :params

		Struct.new("ConfigureParams", :base_url, :merchant_id, :merchant_key, :version, :metadata)
		
		# Initializes a ZipMoney::Configure object
        #
        # Returns ZipMoney::Configure object
		def initialize 
			@params 		 = Struct::ConfigureParams.new
			@params.metadata = Struct::Metadata.new
			@params.version  = Struct::Version.new
		end
		
		# Performs the Configure api call on zipMoney endpoint
        #
        # Returns ZipMoney::Configure object	
		def do	
			validate
			ZipMoney.api.configure(self.params)
		end
		
		# Performs the parameters validation
		def validate
			raise ArgumentError, "Params emtpy" if params.nil? 
			@errors = []
          	@errors << 'base_url must be provided' if self.params.txn_id.nil? 
            raise ZipMoney::RequestError.new("Following error(s) occurred while making request, please resolve them to make the request: #{@errors}") if @errors.any?
		end
	end
end
