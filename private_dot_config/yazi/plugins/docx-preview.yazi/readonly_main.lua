-- docx.yazi plugin - Preview docx files using pandoc
local M = {
	cache = {},
	cache_order = {},
}
local MAX_CACHE = 8

local function get_file_path(file)
	return tostring(file.path or file.cache or file.url.path or file.url)
end

local function cache_get(key)
	local v = M.cache[key]
	if not v then
		return nil
	end
	-- move to end (most recently used)
	for i, k in ipairs(M.cache_order) do
		if k == key then
			table.remove(M.cache_order, i)
			break
		end
	end
	table.insert(M.cache_order, key)
	return v
end

local function cache_put(key, value)
	if M.cache[key] then
		-- update order
		for i, k in ipairs(M.cache_order) do
			if k == key then
				table.remove(M.cache_order, i)
				break
			end
		end
	else
		-- evict if needed
		if #M.cache_order >= MAX_CACHE then
			local old = table.remove(M.cache_order, 1)
			if old then
				M.cache[old] = nil
			end
		end
	end
	M.cache[key] = value
	table.insert(M.cache_order, key)
end

local function render_docx(file_path)
	local output, err = Command("pandoc"):arg({ "-t", "plain", "--wrap=auto", "--columns=100", file_path }):output()

	if err then
		return nil, "pandoc command failed: " .. tostring(err)
	end

	if not output or not output.status.success then
		local stderr = output and output.stderr or "no output"
		return nil, "pandoc exited with error: " .. stderr
	end

	local text = output.stdout or ""
	if text == "" then
		return {}, nil
	end

	local lines = {}
	for line in text:gmatch("[^\r\n]+") do
		table.insert(lines, ui.Line({ ui.Span(line) }))
	end
	return lines, nil
end

function M:peek(job)
	local file_path = get_file_path(job.file)

	-- cache hit
	local lines = cache_get(file_path)
	if not lines then
		local err
		lines, err = render_docx(file_path)
		if err then
			ya.preview_widget(
				job,
				ui.Text({
					ui.Line({ ui.Span("Docx Preview Error"):style(ui.Style():fg("red"):bold()) }),
					ui.Line({}),
					ui.Line({ ui.Span(err):style(ui.Style():fg("yellow")) }),
					ui.Line({ ui.Span("File: " .. file_path):style(ui.Style():fg("blue")) }),
				})
					:area(job.area)
					:wrap(ui.Wrap.YES)
			)
			return
		end

		cache_put(file_path, lines)
	end

	if #lines == 0 then
		ya.preview_widget(
			job,
			ui.Text({
				ui.Line({ ui.Span("No text content found"):style(ui.Style():fg("yellow")) }),
			}):area(job.area)
		)
		return
	end

	-- pagination
	local skip = job.skip or 0
	local limit = job.area.h
	local start_idx = skip + 1
	local end_idx = math.min(start_idx + limit - 1, #lines)

	local page_lines = {}
	for i = start_idx, end_idx do
		table.insert(page_lines, lines[i])
	end

	ya.preview_widget(job, ui.Text(page_lines):area(job.area):wrap(ui.Wrap.YES))
end

function M:seek(job)
	local h = cx.active.current.hovered
	if h and h.url == job.file.url then
		ya.emit("peek", {
			math.max(0, cx.active.preview.skip + job.units),
			only_if = job.file.url,
		})
	end
end

return M
