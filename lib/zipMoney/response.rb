module ZipMoney
	class Response
		
		attr_accessor :_response , :_responseBody, :_responseHeader, :_statusCode

		def initialize(response)
	        raise ArgumentError, "Response doesnot exist" if ((response.nil? || response.empty?) && response.code.nil? && response.code.empty?)
			self._response  	 = response
			self._statusCode 	 = response.code
			self._responseBody   = response.body
		end			
	
		def toHash
	        raise ResponseError, "Response body doesnot exist" if _responseBody.nil? || _responseBody.empty?
			JSON.parse(self._responseBody) 
		end

    	def toObject
	        raise ResponseError, "Response body doesnot exist" if _responseBody.nil? || _responseBody.empty?
			responseObject = JSON.parse(self._responseBody, object_class: OpenStruct)
			responseObject
		end

		def getRedirectUrl
	        raise ArgumentError, "Response body doesnot exist" if _responseBody.nil? || _responseBody.empty?
	        resObj = toObject
			return false if resObj.redirect_url.nil?  || resObj.redirect_url.empty?
			resObj.redirect_url
		end

		def getStatusCode
			self._statusCode
		end	

		def isSuccess
			return self._statusCode == 200 || self._statusCode == 201? true : false
		end

		def getError
	        raise ArgumentError, "Response body doesnot exist" if _responseBody.nil? || _responseBody.empty?
	        resObj = toObject
	        resObj.Message
		end
	end
end
