;; inherits: markdown_inline
;; extends
(inline
    (code_span) @injection.content (#lua-match? @injection.content "^`@.*`$")
    (#set! injection.language "lua")
)
