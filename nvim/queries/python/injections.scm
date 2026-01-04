;; inherits: python
;; extends

(call
    function: (attribute attribute: (identifier) @name (#eq? name "executescript"))
    arguments: (argument_list (string (string_content) @injection.content (#set! injection.language "sql")))
)
