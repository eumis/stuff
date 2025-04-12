;; inherits: lua
;; extends

(function_call
    (method_index_expression
        method: (identifier) @method (#eq? @method "raw")
    )
    (arguments
        (string
          content: (string_content) @injection.content (#set! injection.language "markdown")
        )
    )
)

; highlight snippet syntax
(function_call
    name: (dot_index_expression
        field: (identifier) @method (#eq? @method "add_snippets")
    )
    arguments: (arguments
        (string
            content: (string_content) @lan (#eq? @lan "python")
        )
        (table_constructor
            (field
                value: (function_call
                    ; name: (identifier) @s (#eq? @s "s")
                    arguments: (arguments
                        ; (string content: (string_content) @name)
                        (function_call
                            name: (identifier) @fmt (#eq? @fmt "fmt")
                            arguments: (arguments
                                (string content: (string_content) @injection.content (#set! injection.language "python"))
                            )
                        )
                    )
                )
            )
        )
    )
)

(function_call
    name: (dot_index_expression
        field: (identifier) @method (#eq? @method "add_snippets")
    )
    arguments: (arguments
        (string
            content: (string_content) @lan (#eq? @lan "cs")
        )
        (table_constructor
            (field
                value: (function_call
                    ; name: (identifier) @s (#eq? @s "s")
                    arguments: (arguments
                        ; (string content: (string_content) @name)
                        (function_call
                            name: (identifier) @fmt (#eq? @fmt "fmt")
                            arguments: (arguments
                                (string content: (string_content) @injection.content (#set! injection.language "c_sharp"))
                            )
                        )
                    )
                )
            )
        )
    )
)
