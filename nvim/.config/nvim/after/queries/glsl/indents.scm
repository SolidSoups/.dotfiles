; Indent rules for GLSL
[
  (compound_statement)
  (declaration)
  (if_statement)
  (for_statement)
  (while_statement)
  (do_statement)
  (switch_statement)
] @indent.begin

[
  "}"
  "]"
  ")"
] @indent.branch

[
  (comment)
  (preproc_def)
  (preproc_function_def)
  (preproc_call)
] @indent.auto

(compound_statement
  "}" @indent.end)

(ERROR) @indent.auto
