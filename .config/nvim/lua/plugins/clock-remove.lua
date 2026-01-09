return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options.section_separators = { left = "", right = "" }
    opts.options.component_separators = { left = "", right = "" }
    opts.sections.lualine_z = vim.tbl_filter(function(component)
      if type(component) == "function" then
        return false 
      end
      if type(component) == "table" and type(component[1]) == "function" then
         return false
      end
      return true
    end, opts.sections.lualine_z)
  end,
}
