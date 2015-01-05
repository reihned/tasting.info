require 'mustache'
require 'active_record'

def render_full(content)
  render = File.read('./template/main.html')
  result = Mustache.render(render, {content: content})
  result
end
