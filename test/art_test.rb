require 'test_helper'

class Art::Test < ActiveSupport::TestCase

  test 'macros included' do
    assert Post.respond_to? :translated
    assert Post.respond_to? :translator
  end

  # translated

  test 'translated has one translator proxy' do
    assert_has_one Post, :translator_proxy
    assert Post.first.translator_proxy.is_a? PostTranslation
  end

  test 'translated has many translator' do
    assert_has_many Post, :post_translations
  end

  test 'translated class name' do
    [Post, PostTranslation].each do |klass|
      assert_equal 'Post', klass.send(:translated_class_name)
    end
  end

  test 'translated relation name' do
    [Post, PostTranslation].each do |klass|
      assert_equal 'post' ,klass.send(:translated_relation_name)
    end
  end

  test 'translated class' do
    [Post, PostTranslation].each do |klass|
      assert_equal Post ,klass.send(:translated_class)
    end
  end

  # translator
  test 'translator belongs to translated' do
    assert_belongs_to PostTranslation, :post
  end

  test 'translator class name' do
    [Post, PostTranslation].each do |klass|
      assert_equal 'PostTranslation', klass.send(:translator_class_name)
    end
  end

  test 'translator relation name' do
    [Post, PostTranslation].each do |klass|
      assert_equal 'post_translations' ,klass.send(:translator_relation_name )
    end
  end

  test 'translator class' do
    [Post, PostTranslation].each do |klass|
      assert_equal PostTranslation ,klass.send(:translator_class)
    end
  end

  test 'translate' do
    I18n.locale = :en
    assert_equal 'post title', Post.first.title
    I18n.locale = :ja
    assert_equal 'ポストタイトル', Post.first.title
  end


end
