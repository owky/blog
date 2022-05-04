class BotAction
  class Blog
    JEKYLL_POST_DIR = "_posts"
    JEKYLL_DRAFT_DIR = "_drafts"
    JEKYLL_DRAFT_DOCKER_COMMAND = "docker run --rm -v ${PWD}:/work jekyll build --drafts"
    JEKYLL_DRAFT_URL = "http://192.168.11.60/blog/"
    BLOG_TEMPLATE = <<EOS
---
layout: post
title:  "<%= blog_title %>"
---
<%= blog_body %>
EOS

    def self.preview(messages)
      article = build_article(messages)

      file_name = Time.now.strftime("%Y-%m-%d-draft.md")
      File.open("#{JEKYLL_DRAFT_DIR}/#{file_name}", "w") do |file|
        file.puts article
      end

      `#{JEKYLL_DRAFT_DOCKER_COMMAND}`
      JEKYLL_DRAFT_URL
    end

    def self.post(file_name)
      draft_file = Time.now.strftime("%Y-%m-%d-draft.md")
      post_file = Time.now.strftime("%Y-%m-%d-#{file_name}.md")
      `mv #{JEKYLL_DRAFT_DIR}/#{draft_file} #{JEKYLL_POST_DIR}/#{post_file}`
      `git add #{JEKYLL_POST_DIR}/#{post_file}`
      `git commit -m "Blog post. #{post_file}"`
      `git push origin HEAD`
    end

    def self.build_article(messages)
      document = []
      messages.each do |msg|
        document << msg.to_markdown
      end

      blog_title = document.shift
      blog_body = document.join("\n\n")

      ERB.new(BLOG_TEMPLATE).result binding
    end
  end
end
