require "test_helper"

class NomicsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get nomics_index_url
    assert_response :success
  end
end
