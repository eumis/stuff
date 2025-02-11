;; inherits: markdown
;; extends
(fenced_code_block
    (info_string) @lan (#eq? @lan "luamd")
    (code_fence_content) @injection.content
        (#set! injection.language "lua")
)

