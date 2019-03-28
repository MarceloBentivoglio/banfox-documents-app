require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get documents_index_url
    assert_response :success
  end

  test "should get view" do
    get documents_view_url
    assert_response :success
  end

end
