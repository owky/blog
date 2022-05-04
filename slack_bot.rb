# $ export SLACK_APP_TOKEN=`cat slack-bot/SLACK_APP_TOKEN`
# $ export SLACK_BOT_TOKEN=`cat slack-bot/SLACK_BOT_TOKEN`

require 'sardonyx_ring'
require 'erb'
require './slack-bot/blog'
require './slack-bot/slack_message'

class SlackBot < SardonyxRing::App
  BOT_USER_ID = "U02U6H8F0SE"
  BOT_HELP_MESSAGE_FILE = "slack-bot/bot_help.md"

  event 'app_mention' do |event|
    Thread.start(event) { |e| reply(e.raw_payload.event) }
  end

  private
  def reply(event)
    channel = event.channel
    thread_ts = event.thread_ts

    case event.text
    when /Happy/
      post(":cat2: Lucky Smile Yeah !", channel, thread_ts)
    when /help/
      help_message = File.read(BOT_HELP_MESSAGE_FILE)
      post(help_message, channel, thread_ts)
    when /blog preview/
      thread = client.conversations_replies(channel: channel, ts: thread_ts)
      messages = exclude_bot_message(thread.messages).map { |msg| SlackMessage.new msg }
      url = BotAction::Blog.preview(messages)
      post(url, channel, thread_ts)
    when /blog post (.+)/
      BotAction::Blog.post($1.strip)
      post(":cat2: I just posted.", channel, thread_ts)
    else
      post(":cat2: meow", channel, thread_ts)
    end
  end

  def exclude_bot_message(messages)
    messages.delete_if do |m|
      m.text =~ /\<\@.+\>/ or m.user == BOT_USER_ID
    end
  end

  def post(msg, channel, thread)
    client.chat_postMessage(text: msg, channel: channel, thread_ts: thread)
  end
end

SlackBot.new(
  app_token: ENV['SLACK_APP_TOKEN'],
  bot_token: ENV['SLACK_BOT_TOKEN'],
  logger: Logger.new($stdout, level: :debug)
).socket_start!
