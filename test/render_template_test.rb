# frozen_string_literal: true

require_relative "test_helper"

class RenderTemplateTest < Minitest::Test
  TEST_DIR = File.expand_path("tmp_views", __dir__)

  def setup
    FileUtils.mkdir_p(TEST_DIR)

    File.write(
      File.join(TEST_DIR, "post.html.erb"),
      "<h1><%= post %></h1>"
    )
  end

  def teardown
    FileUtils.rm_rf(TEST_DIR)
  end

  def test_render_template_with_locals
    renderer = TestRenderer.new

    output = renderer.render_template(
      File.join(TEST_DIR, "post"),
      post: "Hello ERB"
    )

    assert_equal "<h1>Hello ERB</h1>", output
  end
end

