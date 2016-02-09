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
	    end
	end	
end