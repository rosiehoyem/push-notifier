require 'gcm'

class AndroidAlertWorker
	include Sidekiq::Worker
	include Sidekiq::Schedulable

	recurrence do 
		weekly(1).
			day(:monday, :tuesday, :wednesday, :thursday, :friday).
			hour_of_day((8..16).to_a).
			minute_of_hour(0, 30)
	end

	sidekiq_options :queue => :android_alert_worker_queue, backtrace: true, retry: true

	def perform
		registration_ids = User.joins(:device).where('devices.platform = ?', 'android').
			gcm = GCM.new(ENV['gcm_key'])
			options = {
				'data' => {
					'message' => "hello from GCM!"
				},
					'collapse_key' => 'this_messages_key'
			}
			response = gcm.send_notification(registration_ids, options)
		end
	end
end
