# $ SLACK_APP_TOKEN=`cat SLACK_APP_TOKEN`
# $ SLACK_BOT_TOKEN=`cat SLACK_BOT_TOKEN`

require 'sardonyx_ring'

class HappyBot < SardonyxRing::App
  event 'app_mention' do |event|
    Thread.start(event) { |e| reply(e.raw_payload.event) }
  end

  private
  def reply(event)
    case event.text
    when /Happy/
      post("Lucky Smile Yeah !", event.channel, event.thread_ts)
    when /jekyll draft (.+)/
      post(jekyll_draft($1.strip), event.channel, event.thread_ts)
    when /jekyll publish (.+)/
      post(jekyll_publish($1.strip), event.channel, event.thread_ts)
    when /jekyll build/
      post(jekyll_build, event.channel, event.thread_ts)
    else
      response = client.conversations_replies(channel: event.channel, ts: event.thread_ts)

      document = []
      extract_bot_message(response.messages).each do |msg|
        msg.blocks.each do |block|
          document << RichTextBlock.new(block).convert
        end
      end

      #      post("meow", event.channel, event.thread_ts)
      post(document.join("\n\n"), event.channel, event.thread_ts)
    end
  end

  def extract_bot_message(messages)
    messages.delete_if do |m|
      m.text =~ /\<\@.+\>/ or m.user == "U02U6H8F0SE"
    end
  end

  def jekyll_draft(file_name)
    `docker run --rm -v /home/owky2413/git/blog:/work -v /home/owky2413/Dropbox/_drafts:/work/_drafts blog draft #{file_name}`
    $?.success? ? "Draft file has been created. Go to StackEdit. https://stackedit.io/app#" : "Error"
  end

  def jekyll_publish(file_name)
    Jekyll.publish(file_name)
  end

  def jekyll_build
    Jekyll.build
  end

  def post(msg, channel, thread)
    client.chat_postMessage(text: ":cat2: " + msg, channel: channel, thread_ts: thread)
  end
end

class RichTextBlock
  def initialize(obj)
    @rtx_block_obj = obj
  end

  def convert
    @rtx_block_obj.elements.map do |e|
      RichTextElement.guess(e).convert
    end.join("\n")
  end
end

class RichTextElement
  def initialize(rtx_obj)
    @rich_text_object = rtx_obj
  end

  def self.guess(rtx_obj)
    case rtx_obj.type
    when "rich_text_section"
      return Section.new(rtx_obj)
    when "rich_text_list"
      return List.new(rtx_obj)
    else
      raise
    end
  end
end

class Section < RichTextElement
  def convert
    @rich_text_object.elements.map do |e|
      e.text
    end.join
  end
end

class List < RichTextElement
  def convert
    indent = @rich_text_object.indent
    @rich_text_object.elements.map do |e|
      "    " * indent + "* #{e.elements.first.text.strip}"
    end.join("\n")
  end
end

class Jekyll
  def self.build
    `docker run --rm -v /home/owky2413/git/blog:/work -v /home/owky2413/Dropbox/_drafts:/work/_drafts blog build --drafts`
    $? ? "Build completed. http://192.168.11.60/blog/" : "Error."
  end

  def self.publish(file_name)
    res = `docker run --rm -v /home/owky2413/git/blog:/work -v /home/owky2413/Dropbox/_drafts:/work/_drafts blog publish _drafts/#{file_name}.md`
    if res =~ /Draft .+ was moved to (.+)/
      post = $1.strip
      title = nil
      File.open('/home/owky2413/git/blog/' + post).readlines.each do |l|
        title = $1.strip if l =~ /title: (.+)/
      end
      if title
        `cd /home/owky2413/git/blog ; git add #{post} ; git commit -m "#{title}" ; git push origin HEAD`
      else
        "Error."
      end
    else
      "jekyll publish : Error"
    end
  end

  def title(file_name)
  end
end

HappyBot.new(
  app_token: ENV['SLACK_APP_TOKEN'],
  bot_token: ENV['SLACK_BOT_TOKEN'],
  logger: Logger.new($stdout, level: :debug)
).socket_start!

