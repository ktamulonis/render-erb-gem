# Render ERB gem

A simple library for rendering erb templates and passing locals to the template.

render method

```ruby
path_to_file = "home.html.erb"

message = "Hello World!"

render_template(path_to_file, message: message) # => HTML CONTENT.
```

`/home.html.erb`
```
<h1> <%= message %> </h1>
```

### Installation steps

to use the render_template method in your app you must 1. install the gem. 2. require the gem in your file. 3. include the RenderErb module to access the render_template method.

Step 1.

```sh
bundle add render_erb
```

Step 2.

```sh
require "render_erb"
```

Step 3.

```sh
include RenderErb
```