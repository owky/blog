# Slack message structure:
# message : {
#   blocks: []
# }
# block : {
#   elements: []
# }
# element : {
#   type: ""
# }
#
# Element has some type:
# - Text
# - Section
# - List
#
# Section and List has nested elements.

class SlackMessage
  def initialize(raw)
    @raw = raw
    @blocks = raw.blocks.map do |block|
      Block.new(block)
    end
  end

  def to_markdown
    @blocks.map { |block| block.to_markdown }.join
  end

  class Block
    def initialize(raw)
      @raw = raw
      @elements = raw.elements.map do |element|
        Element.guess(element)
      end
    end

    def to_markdown
      @elements.map { |element| element.to_markdown }.join("\n")
    end
  end

  class Element
    def initialize(raw)
      @raw = raw
    end

    def to_markdown
      raise
    end

    def self.guess(raw)
      case raw.type
      when "text"
        return Text.new(raw)
      when "link"
        return Link.new(raw)
      when "rich_text_section"
        return Section.new(raw)
      when "rich_text_list"
        return List.new(raw)
      else
        puts "----- raw object -----"
        puts raw
        raise
      end
    end

    class Text < Element
      def to_markdown
        @raw.text
      end
    end

    class Link < Element
      def url
        @raw.url
      end

      def title
        `curl -s "#{url}" | grep -oP -m1 '(?<=<title>).*(?=</title>)'`
      end

      def to_markdown
        "[#{title}](#{url})"
      end
    end

    class Section < Element
      def initialize(raw)
        super(raw)
        @elements = raw.elements.map { |e| Element.guess(e) }
      end

      def to_markdown
        @elements.map { |e| e.to_markdown }.join
      end
    end

    class List < Element
      LIST_STYLE = {
        "bullet" => "*",
        "ordered" => "1.",
      }

      def initialize(raw)
        super(raw)
        @elements = raw.elements.map { |e| Element.guess(e) }
      end

      def indent
        @raw.indent
      end

      def style
        @raw.style
      end

      def to_markdown
        @elements.map do |e|
          "    " * indent + "#{LIST_STYLE[style]} #{e.to_markdown}"
        end.join("\n")
      end
    end
  end
end
