class IosAlertWorker
	include Sidekiq::Worker
	include Sidekiq::Schedulable

	recurrence do 
		weekly(1).
			day(:monday, :tuesday, :wednesday, :thursday, :friday).
			hour_of_day((8..16).to_a).
			minute_of_hour(0, 30)
	end

	sidekiq_options :queue => :ios_alert_worker_queue, backtrace: true, retry: true

	def perform
		pusher = Grocer.pusher(
			certificate: "/path/to/cert.pen",
			passphrase: "",
			gateway: "gateway.push.apple.com",
			port: 2195,
			retries: 3
			)

		User.joins(:device).where('devices.platform =?', 'ios').pluck('devices.token').each do |token|
			notification = Grocer::Notification.new(
				device_token: token
				alert: "Hello from Grocer!",
				badge: 42,
				sound: "siren.aiff",
				expiry: Time.now + 60+60,
				identifier: 1234,
				content_available: true
				)
			pusher.push(notification)
		end
	end
end

