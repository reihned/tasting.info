require 'mustache'
require 'active_record'

def render_full(content)
  render = File.read('./template/main.html')
  nav = File.read('./template/nav.html')
  result = Mustache.render(render, {content: content, nav: nav})
  result
end
