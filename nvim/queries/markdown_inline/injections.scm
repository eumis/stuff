;; inherits: markdown_inline
;; extends
(inline
    (code_span) @injections.content (#match? @injections.content "`luamd.*`")
    (#set! injection.language "lua")
)
