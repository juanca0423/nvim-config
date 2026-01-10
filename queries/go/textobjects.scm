;;queries/go/textobjects.scm
(function_declaration
  name: (identifier) @test.name
  parameters: (parameter_list
    (parameter_declaration
      type: (pointer_type) @_recv))
  (#match? @_recv "*T")
) @test.type
