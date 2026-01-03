# render_template
# allow user of gem to access this method.
# render_template "post", post: post

require "erb"

module RenderErb
  attr_reader :file_with_ext

  def render_template(file_path, **locals)
    @file_with_ext = add_file_extension(file_path)
    file_content = File.read(file_with_ext)
    template = ERB.new(file_content)
    bind = binding
    locals.each do |k, v|
      bind.local_variable_set(k, v)
    end
    template.result(bind)
  end

  def render_partial(name, **locals)
    partial_path = File.join(
      File.dirname(file_with_ext),
      "_#{name}"
    )

    render_template(partial_path, **locals)
  end

private

  def add_file_extension(file_path)
    file_path.gsub(".html.erb", "") + ".html.erb"
  end
end
