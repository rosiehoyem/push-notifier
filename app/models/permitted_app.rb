class PermittedApp < ActiveRecord::Base
	before_save :ensure_authentication_token!

	def ensure_authentication_token!
		if authentication_token.blank?
			self.authentication_token = generate_secure_token_string
		end
	end

	def generate_secure_token_string
		SecureRandom.urlsafe_fase64(25).tr('lIO0', 'sxyz')
	end
end
