# frozen_string_literal: true

require_relative "test_helper"

class RenderPartialTest < Minitest::Test
  TEST_DIR = File.expand_path("tmp_views", __dir__)

  def setup
    FileUtils.mkdir_p(TEST_DIR)

    File.write(
      File.join(TEST_DIR, "page.html.erb"),
      <<~ERB
        <%= render_partial "header", title: "Welcome" %>
        <p>Main content</p>
      ERB
    )

    File.write(
      File.join(TEST_DIR, "_header.html.erb"),
      "<h1><%= title %></h1>"
    )
  end

  def teardown
    FileUtils.rm_rf(TEST_DIR)
  end

  def test_render_partial_inside_template
    renderer = TestRenderer.new

    output = renderer.render_template(
      File.join(TEST_DIR, "page")
    )

    assert_includes output, "<h1>Welcome</h1>"
    assert_includes output, "<p>Main content</p>"
  end

  def test_render_partial_with_multiple_locals
    File.write(
      File.join(TEST_DIR, "page.html.erb"),
      <<~ERB
        <%= render_partial "header",
              title: "Hello",
              subtitle: "World"
        %>
      ERB
    )

    File.write(
      File.join(TEST_DIR, "_header.html.erb"),
      <<~ERB
        <h1><%= title %></h1>
        <h2><%= subtitle %></h2>
      ERB
    )

    renderer = TestRenderer.new

    output = renderer.render_template(
      File.join(TEST_DIR, "page")
    )

    assert_includes output, "<h1>Hello</h1>"
    assert_includes output, "<h2>World</h2>"
  end
end

