vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.man",
  callback = function()
    vim.bo.filetype = "mania"

    -- Quote
    vim.cmd("syntax match MyLangQuote '\".*\"'")
    -- Words
    vim.cmd("syntax match MyLangWord '\\<\\w\\+\\>'")
    -- Combinators
    vim.cmd("syntax match MyLangConditional '[?_]'")
    -- Braces and brackets
    vim.cmd("syntax match MyLangOrder '[{}]'")
    vim.cmd("syntax match MyLangBraces '[\\[\\]]'")
    -- Numbers
    vim.cmd("syntax match MyLangNumber '\\<\\d\\+\\>'")
    -- Comments
    vim.cmd("syntax match MyLangFunction ';.*$'")
    -- Methods
    vim.cmd("syntax match MyLangMethod ':.*:' contains=MyLangColon")
    -- Colon
    vim.cmd("syntax match MyLangColon ':' contained")

    -- Link to theme colors
    vim.cmd([[
    highlight link MyLangWord        Identifier
    highlight link MyLangMethod      Keyword
    highlight link MyLangOperator    Operator
    highlight link MyLangBraces      Delimiter
    highlight link MyLangStack       Type
    highlight link MyLangNumber      Number
    highlight link MyLangComment     Comment
    highlight link MyLangSpecial     Special
    highlight link MyLangTodo        Todo
    highlight link MyLangFunction    Function
    highlight link MyLangOrder      Special
    highlight link MyLangColon      Special
    highlight link MyLangConditional Type
    highlight link MyLangStatement   Statement
    highlight link MyLangError       Error
    highlight link MyLangQuote       Number
    highlight link MyLangParam       Special
    ]])
  end
})
