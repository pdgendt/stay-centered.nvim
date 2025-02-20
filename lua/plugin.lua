local mode = require("mode")

local function must_skip_file(skip_filetypes, current_type)
	if skip_filetypes == nil then
		return false
	end

	for _, value in ipairs(skip_filetypes) do
		if value == current_type then
			return true
		end
	end

	return false
end

local function stay_centered(ctx)
	if must_skip_file(ctx.skip_filetypes, vim.bo.filetype) then
		return
	end

	local line = vim.api.nvim_win_get_cursor(0)[1]
	if line ~= vim.b.last_line then
		vim.cmd("norm! zz")
		vim.b.last_line = line
		if ctx.mode == mode.insert then
			local column = vim.fn.getcurpos()[5]
			vim.fn.cursor({ line, column })
		end
	end
end

return {
	stay_centered = stay_centered,
}
