require 'mustache'
require 'active_record'

def render_full(content)
  render = File.read('./templates/main.html')
  nav = File.read('./templates/nav.html')
  result = Mustache.render(render, {content: content, nav: nav})
  result
end
