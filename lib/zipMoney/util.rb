module ZipMoney
	class Util
		class << self
			def set_instance_variables_from_hash(hash)
	        	hash.each do |key, value|
	          		instance_variable_set "@#{key}", value
	        	end
	      	end

	      	def struct_to_hash(object)
	      		hash = {}
	      		object.to_h.each  do |k,v| 
	      			if v.is_a?(Struct) 
	      			 	v = struct_to_hash(v)
	      			 	hash[k] = v
	      			elsif v.is_a?(Array)
	      			 	a = Array.new
	      			    v.each_with_index{ |k1,v1|   a[v1] = struct_to_hash(k1) }
	      			 	hash[k] = a
	      			else
	      			 	hash[k] = v
	      		    end
	      		end
				hash
	      	end	

	      	def json_parse(data)
	    		begin
				    data =  JSON.parse(data)
				rescue TypeError => e					
				    if !data.is_a?(Hash) && !data.is_a?(Struct) && !data.is_a?(OpenStruct)
		        		raise ArgumentError, "Invalid params provided" 
					end
				rescue JSON::ParserError => e
				    if !data.is_a?(Hash) && !data.is_a?(Struct) && !data.is_a?(OpenStruct)
		        		raise ArgumentError, "Invalid params provided" 
					end
				end
				data
    		end

    		def credentials_valid(merchant_id,merchant_key)
	    		if !Configuration.merchant_id.eql?(merchant_id) || !Configuration.merchant_key.eql?(merchant_key)
					raise ExpressError, "Invalid merchant credentials in the request" 
	    		end	
	    	end
	    end
	end	
end