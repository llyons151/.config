-- after/plugin/telescope.lua
local ok, telescope = pcall(require, "telescope")
if not ok then return end

local actions        = require("telescope.actions")
local layout_actions = require("telescope.actions.layout")

telescope.setup({
  defaults = {
    sorting_strategy = "ascending",
    prompt_prefix    = " ● ",
    selection_caret  = " ● ",
    path_display     = { "truncate" },

    layout_strategy  = "flex",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width   = 0.55,
        results_width   = 0.45,
        width           = 0.98,
        height          = 0.95,
      },
      vertical = {
        prompt_position = "top",
        preview_height  = 0.45,
        width           = 0.98,
        height          = 0.98,
      },
      center = {
        width           = 0.60,
        height          = 0.55,
        prompt_position = "top",
        preview_cutoff  = 40,
      },
      cursor = {
        width           = 0.80,
        height          = 0.90,
        preview_cutoff  = 40,
      },
      bottom_pane = {         -- “ivy-like” without using the ivy theme
        height          = 25, -- rows
        prompt_position = "bottom",
        preview_cutoff  = 120,
      },
      flex = { flip_columns = 140 },
    },

    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-p>"] = layout_actions.toggle_preview,
        ["<C-l>"] = layout_actions.cycle_layout_next,
        ["<C-h>"] = layout_actions.cycle_layout_prev,
        ["<Esc>"] = actions.close,
      },
      n = {
        ["p"] = layout_actions.toggle_preview,
        ["l"] = layout_actions.cycle_layout_next,
        ["h"] = layout_actions.cycle_layout_prev,
        ["q"] = actions.close,
      },
    },

    dynamic_preview_title = true,
  },

  pickers = {
    find_files = {
      hidden     = false,
      follow     = true,
      no_ignore  = false,
      previewer  = false,
      theme      = "dropdown",  
    },
    buffers = {
      sort_mru = true,
      ignore_current_buffer = true,
      theme = "ivy",           
      mappings = {
        i = { ["<C-d>"] = actions.delete_buffer },
        n = { ["d"]     = actions.delete_buffer },
      },
    },
    live_grep   = { layout_strategy = "vertical" },
    oldfiles    = { theme = "dropdown", previewer = false },
    help_tags   = { layout_strategy = "vertical" },
  },
})

pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "live_grep_args")
