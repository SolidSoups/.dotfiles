; Inject GLSL into template strings assigned to shader-related variables
; Matches: const vertexShader = `...`, const fragment = `...`, etc.
((variable_declarator
  name: (identifier) @_name
  value: (template_string) @injection.content)
 (#lua-match? @_name "[Ss]hader$")
 (#offset! @injection.content 0 1 0 -1)
 (#set! injection.language "glsl"))

((variable_declarator
  name: (identifier) @_name
  value: (template_string) @injection.content)
 (#lua-match? @_name "^vertex")
 (#offset! @injection.content 0 1 0 -1)
 (#set! injection.language "glsl"))

((variable_declarator
  name: (identifier) @_name
  value: (template_string) @injection.content)
 (#lua-match? @_name "^fragment")
 (#offset! @injection.content 0 1 0 -1)
 (#set! injection.language "glsl"))

((variable_declarator
  name: (identifier) @_name
  value: (template_string) @injection.content)
 (#lua-match? @_name "^frag")
 (#offset! @injection.content 0 1 0 -1)
 (#set! injection.language "glsl"))

((variable_declarator
  name: (identifier) @_name
  value: (template_string) @injection.content)
 (#lua-match? @_name "^vert")
 (#offset! @injection.content 0 1 0 -1)
 (#set! injection.language "glsl"))

; Match glsl tagged template literals: glsl`...`
((call_expression
  function: (identifier) @_name
  arguments: (template_string) @injection.content)
 (#eq? @_name "glsl")
 (#offset! @injection.content 0 1 0 -1)
 (#set! injection.language "glsl"))
