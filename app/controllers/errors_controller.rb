class ErrorsController < ActionController::Base

	def not_found
		respond_to do |format|
			format.html { render template: 'errors/not_found', layout: 'layouts/application', status: 404 }
			format.all  { render nothing: true, status: 404 }
		end
	end
	
	def unprocessable_entity
		respond_to do |format|
			format.html { render template: 'errors/unprocessable_entity', layout: 'layouts/application', status: 422 }
			format.all  { render nothing: true, status: 422 }
		end
	end
	
	def internal_server_error
		respond_to do |format|
			format.html { render template: 'errors/internal_server_error', layout: 'layouts/application', status: 500 }
			format.all  { render nothing: true, status: 500 }
		end
	end

end
