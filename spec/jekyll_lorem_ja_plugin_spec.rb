# -*- coding: utf-8 -*-
require 'spec_helper'

describe JekyllLoremJaPlugin do
  it 'has a version number' do
    expect(JekyllLoremJaPlugin::VERSION).not_to be nil
  end

  it 'render loremja_word' do
    expect(Liquid::Template.parse("{% loremja_word  %}").render.size).to be >= 2
    expect(Liquid::Template.parse("{% loremja_words  %}").render.size).to be >= 2
    expect(Liquid::Template.parse("{% loremja_words 5  %}").render.size).to be >= (2*5)
    expect(Liquid::Template.parse("{% loremja_sentence  %}").render.size).to be >= ((2*6))
    expect(Liquid::Template.parse("{% loremja_sentences 5  %}").render.size).to be >= ((2*6) * 5)
    expect(Liquid::Template.parse("{% loremja_paragraph  %}").render.size).to be >= ((2*6) * 2)
    expect(Liquid::Template.parse("{% loremja_paragraphs 5  %}").render.size).to be >= (((2*6) * 2) * 5)
    expect(Liquid::Template.parse("{% loremja_date  %}").render).to match /^\d{4}年\d{2}月\d{2}日$/
    expect(Liquid::Template.parse("{% loremja_image 100x100 %}").render).to match %r!^http://placehold.it/100x100$!

    Liquid::Template.parse("{% loremja_reload chuumon_no_ooi_ryouriten %}").render
    expect(Liquid::Template.parse("{% loremja_word  %}").render.size).to be >= 2
    expect(Liquid::Template.parse("{% loremja_words  %}").render.size).to be >= 2
    expect(Liquid::Template.parse("{% loremja_words 5  %}").render.size).to be >= (2*5)
    expect(Liquid::Template.parse("{% loremja_sentence  %}").render.size).to be >= ((2*6))
    expect(Liquid::Template.parse("{% loremja_sentences 5  %}").render.size).to be >= ((2*6) * 5)
    expect(Liquid::Template.parse("{% loremja_paragraph  %}").render.size).to be >= ((2*6) * 2)
    expect(Liquid::Template.parse("{% loremja_paragraphs 5  %}").render.size).to be >= (((2*6) * 2) * 5)
    expect(Liquid::Template.parse("{% loremja_date  %}").render).to match /^\d{4}年\d{2}月\d{2}日$/
    expect(Liquid::Template.parse("{% loremja_image 100x100 %}").render).to match %r!^http://placehold.it/100x100$!
  end
end
