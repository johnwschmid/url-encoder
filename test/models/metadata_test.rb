require 'test_helper'

class MetadataTest < ActiveSupport::TestCase
  test 'returns title' do
    assert_equal 'test', Metadata.new('<title>test</title>').title
  end
  test 'missing title attr' do
    assert_nil Metadata.new.title
  end
  test 'returns desc' do
    assert_equal 'test', Metadata.new("<meta name='description' content='test'></meta>").desc
  end
  test 'missing desc attr' do
    assert_nil Metadata.new.desc
  end
  test 'returns img' do
    assert_equal 'https://test.org', Metadata.new("<meta property='og:image' content='https://test.org'></meta>").image
  end
  test 'missing img attr' do
    assert_nil Metadata.new.image
  end
end