require "ya_lorem_ja"
require 'thread'
require 'liquid'
require "jekyll_lorem_ja_plugin/version"


module JekyllLoremJaPlugin
  class LoremJaObject
    #include Singleton
    #attr_reader :lorem

    @@singleton__instance__ = nil
    @@singleton__mutex__ = Mutex.new

    def self.instance(resource_name=::YaLoremJa::Lorem::DEFAULT_RESOURCE_NAME, char_count_range=::YaLoremJa::Lorem::DEFAULT_CHAR_COUNT_RANGE_IN_WORD, word_count_range=::YaLoremJa::Lorem::DEFAULT_WORD_COUNT_RANGE_IN_SENTENCE, sentence_count_range=::YaLoremJa::Lorem::DEFAULT_SENTENCE_COUNT_RANGE_IN_PARAGRAPH)
      return @@singleton__instance__ if @@singleton__instance__
      @@singleton__mutex__.synchronize {
        return @@singleton__instance__ if @@singleton__instance__
        @@singleton__instance__ = ::YaLoremJa::Lorem.new(resource_name, char_count_range, word_count_range, sentence_count_range)
      }
      @@singleton__instance__
    end

    def self.reload_resource(resource_name=::YaLoremJa::Lorem::DEFAULT_RESOURCE_NAME, char_count_range=::YaLoremJa::Lorem::DEFAULT_CHAR_COUNT_RANGE_IN_WORD, word_count_range=::YaLoremJa::Lorem::DEFAULT_WORD_COUNT_RANGE_IN_SENTENCE, sentence_count_range=::YaLoremJa::Lorem::DEFAULT_SENTENCE_COUNT_RANGE_IN_PARAGRAPH)
      @@singleton__mutex__.synchronize {
        if @@singleton__instance__ == nil
          @@singleton__instance__ = ::YaLoremJa::Lorem.new(resource_name, char_count_range, word_count_range, sentence_count_range)
        else
          @@singleton__instance__.reload_resource(resource_name, char_count_range, word_count_range, sentence_count_range)
        end
      }
    end

    def self.reset_instance
      @@singleton__mutex__.synchronize {
        @@singleton__instance__  = nil if @@singleton__instance__
      }
    end
    private
    private_class_method :new
  end

  class BaseLoremJaTag < Liquid::Tag
    def initialize(tag_name, count, tokens)
      super
      if count.empty?
        @count = 1
      else
        @count = count.to_i
      end

    end
  end

  class LoremJaWordTag < BaseLoremJaTag
    def render(context)
      "#{LoremJaObject.instance.word}"
    end
  end


  class LoremJaWordsTag < BaseLoremJaTag
    def render(context)
      "#{LoremJaObject.instance.words(@count)}"
    end
  end

  class LoremJaSentenceTag < BaseLoremJaTag
    def render(context)
      "#{LoremJaObject.instance.sentence}"
    end
  end

  class LoremJaSentencesTag < BaseLoremJaTag
    def render(context)
      "#{LoremJaObject.instance.sentences(@count)}"
    end
  end

  class LoremJaParagraphTag < BaseLoremJaTag
    def render(context)
      "#{LoremJaObject.instance.paragraph({ start_sep: "<p>", end_sep: "</p>" })}"
    end
  end

  class LoremJaParagraphsTag < BaseLoremJaTag
    def render(context)
      "#{LoremJaObject.instance.paragraphs(@count, { start_sep: "<p>", end_sep: "</p>" })}"
    end
  end

  class LoremJaDateTag < BaseLoremJaTag
    def initialize(tag_name, fmt, tokens)
      super
      @format = fmt.strip
    end

    def render(context)
      if @format && !@format.empty?
        "#{LoremJaObject.instance.date(@format)}"
      else
        "#{LoremJaObject.instance.date}"
      end
    end
  end

  class LoremJaImageTag < BaseLoremJaTag
    def initialize(tag_name, size, tokens)
      super
      @size = size.strip
    end

    def render(context)
      "#{LoremJaObject.instance.image(@size)}"
    end
  end

  class LoremJaReloadTag < BaseLoremJaTag
    def initialize(tag_name, resource_name, tokens)
      super
      @resource_name = resource_name.strip.to_sym
    end

    def render(context)
      LoremJaObject.reload_resource(@resource_name)
      return nil
    end
  end
end

Liquid::Template.register_tag('loremja_word', JekyllLoremJaPlugin::LoremJaWordTag)
Liquid::Template.register_tag('loremja_words', JekyllLoremJaPlugin::LoremJaWordsTag)

Liquid::Template.register_tag('loremja_sentence', JekyllLoremJaPlugin::LoremJaSentenceTag)
Liquid::Template.register_tag('loremja_sentences', JekyllLoremJaPlugin::LoremJaSentencesTag)

Liquid::Template.register_tag('loremja_paragraph', JekyllLoremJaPlugin::LoremJaParagraphTag)
Liquid::Template.register_tag('loremja_paragraphs', JekyllLoremJaPlugin::LoremJaParagraphsTag)

Liquid::Template.register_tag('loremja_date', JekyllLoremJaPlugin::LoremJaDateTag)
Liquid::Template.register_tag('loremja_image', JekyllLoremJaPlugin::LoremJaImageTag)

Liquid::Template.register_tag('loremja_reload', JekyllLoremJaPlugin::LoremJaReloadTag)
