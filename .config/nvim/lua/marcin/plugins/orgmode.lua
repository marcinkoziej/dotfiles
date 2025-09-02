return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    -- Setup orgmode
    require('orgmode').setup({
        org_agenda_files = {'~/Cloud/Documents/org/*'},
        org_default_notes_file = '~/Cloud/Documents/org/random.org',
        -- align
        org_indent_mode = true,
        --        org_hide_leading_stars = true,
        -- folding does not work sper good in nvim
        org_startup_folded = 'showeverything', -- 'content',
        org_hide_emphasis_markers = true,
        -- headings
        org_todo_keywords = {
            "TODO(t)",
            "IDEA(i)",
            "NEXT(n)",
            "ACTIVE(a)",
            "BLOCK(b)",
            "|",
            "DONE(d)",
        },
        org_ellipsis = "  \u{f48c}",
        org_todo_keyword_faces = {
            TODO = ':foreground #FF79C6 :weight bold',    -- Hot pink: needs attention
            NEXT = ':foreground #8BE9FD :weight bold',    -- Cyan: planned/queued
            ACTIVE = ':foreground #50FA7B :weight bold',  -- Mint green: in progress
            BLOCK = ':foreground #FF6E67 :weight bold',   -- Coral: blocked/issues
            DONE = ':foreground #BD93F9 :weight bold',    -- Lavender: completed
            IDEA = ':foreground #F9AC53 :weight bold',
        },
        -- agenda, custom views:
        -- org_agenda_custom_commands 
        -- capturing!
        -- org_capture_templates 
        mappings = {
            -- https://github.com/nvim-orgmode/orgmode/blob/master/lua/orgmode/config/mappings/init.lua
            org = {
                org_meta_return = '<A-CR>',
                org_insert_heading_respect_content = '<C-CR>',
                org_insert_todo_heading = '<M-S-CR>',
                org_insert_todo_respect_heading = '<C-S-CR>',
                org_todo = '<C-.>',
                org_demote_subtree = '<A-S-Right>',
                org_promote_subtree = '<A-S-Left>',
                org_move_subtree_up = '<A-Up>',
                org_move_subtree_down = '<A-Down>',
                org_do_demote = '<A-Right>',
                org_do_promote = '<A-Left>',
                org_priority_up = '<A-S-Up>',
                org_priority_down = '<A-S-Down>',
                org_toggle_checkbox = '<C-l>',
                org_schedule = '<C-s>',
                org_archive_subtree = '<C-/>',
            }
        }
    })

    -- Set conceallevel for org files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "org",
      callback = function()
        vim.opt_local.conceallevel = 2
        vim.keymap.set('i', '<A-CR>', '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
            silent = true,
            buffer = true,
        })
      end,
    })
  end,
}
