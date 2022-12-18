require "test_helper"
require 'nokogiri'
#doc = Nokogiri::XML(File.read('/home/uliana/projects/laba10/xslt-api/test_xml.xml'))
# xslt = Nokogiri::XSLT(File.read('/home/uliana/projects/laba10/xslt-api/transform.xslt'))
# puts xslt.transform(doc)

class XmlControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'check rss format' do
    get '/', params: { digit: 100, format: :rss }
    assert_response :success
    assert_includes @response.headers['Content-Type'], 'application/rss'
  end
end
