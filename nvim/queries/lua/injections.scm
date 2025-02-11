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
