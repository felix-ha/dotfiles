local M = {}

function M.yank_harpoon_files()
  -- For Harpoon v2
  local harpoon = require("harpoon")
  -- Get the list object
  local list = harpoon:list()
  -- Access the items directly based on the structure we now know
  local items = list.items or {}
  -- print("Found " .. #items .. " items in Harpoon list")
  if #items == 0 then
    print("No files found in Harpoon")
    return
  end
  -- Store current buffer to return to it later
  local current_buf = vim.api.nvim_get_current_buf()
  -- Initialize a variable to accumulate all content
  local all_content = ""
  -- For each marked file in Harpoon
  for i, item in ipairs(items) do
    -- In Harpoon v2, items might be strings or tables with a value property
    local file_path = type(item) == "table" and item.value or item
    -- print("Processing file " .. i .. ": " .. file_path)
    -- Navigate to the file
    local success = pcall(function()
      vim.cmd("edit " .. file_path)
    end)
    if success then
      -- Get the content of the current buffer
      local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      if #buffer_lines > 0 then
        local buffer_content = table.concat(buffer_lines, "\n")
        -- Add the filename as a header
        all_content = all_content .. "\n--- " .. file_path .. " ---\n\n"
        -- Append the buffer content
        all_content = all_content .. buffer_content .. "\n"
        -- print("Added content from: " .. file_path)
      else
        print("No content found in buffer for: " .. file_path)
      end
    else
      print("Failed to navigate to: " .. file_path)
    end
  end
  -- Return to original buffer
  pcall(function() vim.api.nvim_set_current_buf(current_buf) end)
  -- Check if we collected any content
  if all_content == "" then
    print("No content collected from any files")
    return
  end
  -- Set the accumulated content to the unnamed register (")
  vim.fn.setreg('"', all_content)
  -- print("Yanked " .. #all_content .. " characters to register")
  -- Debug: Show register content preview
  local reg_content = vim.fn.getreg('"')
  local preview = reg_content:sub(1, 50):gsub("\n", "\\n")
  print("Register preview: " .. preview .. "...")
  -- Optionally, you can try forcing the content into system clipboard as well
  if vim.fn.has('clipboard') == 1 then
    vim.fn.setreg('+', all_content)
    -- print("Also copied to system clipboard (+)")
  end
end

-- local function inspect_harpoon()
--   local harpoon = require("harpoon")
--   print("Harpoon type: " .. type(harpoon))
--
--   -- Inspect the harpoon object
--   for k, v in pairs(harpoon) do
--     local v_type = type(v)
--     print(k .. " (" .. v_type .. ")")
--   end
--
--   -- Try to access list
--   local list = harpoon:list()
--   print("List type: " .. type(list))
--
--   if type(list) == "table" then
--     for k, v in pairs(list) do
--       local v_type = type(v)
--       print("list." .. k .. " (" .. v_type .. ")")
--     end
--   end
-- end
--
-- inspect_harpoon()

function M.setup()
  vim.api.nvim_create_user_command("YankHarpoonFiles", M.yank_harpoon_files, {})
end

return M

