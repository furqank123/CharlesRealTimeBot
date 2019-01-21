require 'slack-ruby-client'

Slack.configure do |config|
	config.token = ENV['SLACK_API_TOKEN']
	raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::RealTime::Client.new
client_two = Slack::Web::Client.new


mobile_platform = "Android or iOS?"
espn = "ESPN"
netflix = "Netflix"
twitch = "Twitch"
app = " "





client.on :message do |data|
	puts data


	case data.text
	when "charles hi"  then
		client.web_client.chat_postMessage channel: data.channel, text: "Hi <@#{data.user}>!"
	when "charles execute" then
		client.web_client.chat_postMessage channel: data.channel, text: "Please select an App: ESPN,Netflix or Twitch(Case sensitive)"
	when espn then
		app = espn
		client.web_client.chat_postMessage channel: data.channel, text: mobile_platform
	when "iOS" then
		platform = "iOS"
		user = data.user
		client.web_client.chat_postMessage channel: data.channel, text: "Please wait a few minutes while I fetch the results"
		kickOff(app,platform)
		client_two.files_upload(
			channels: data.channel,
			file: Faraday::UploadIO.new('/Users/littlefish/IdeaProjects/CharlesRealTimeBot/session.chls',' '),
			title: 'Logs from Charles.',
			initial_comment: "Here are your logs <@#{user}>, Thank you for your patience!"
			)
	when "Android" then 
		user = data.user
		platform = "Android"
		client.web_client.chat_postMessage channel: data.channel, text: "Please wait a few minutes while I fetch the results"
		kickOff(app,platform)
		client_two.files_upload(
			channels: data.channel,
			file: Faraday::UploadIO.new('/Users/littlefish/IdeaProjects/CharlesRealTimeBot/session.chls',' '),
			title: 'Logs from Charles.',
			initial_comment: "Here are your logs <@#{user}>, Thank you for your patience!"
			)
	when netflix then
		app = netflix
		client.web_client.chat_postMessage channel: data.channel, text: mobile_platform
	when twitch then
		app = twitch
		client.web_client.chat_postMessage channel: data.channel, text: mobile_platform
	when /^charles/ then
		client.web_client.chat_postMessage channel: data.channel, text:"Sorry <@#{data.user}>,I didn't quite get that."
	end
end

def kickOff(app,platform)
	system("bash charles.sh #{app} #{platform}")
end



client.start!
