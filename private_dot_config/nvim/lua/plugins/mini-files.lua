return {
  "echasnovski/mini.files",
  opts = {
    content = {
      sort = function(entries)
        -- 判断名字是否以 . 开头
        local function is_special(name)
          return name:match("^[._]") ~= nil
          -- return name:sub(1, 1) == "."
        end
        -- 给每个 entry 分组：dot-folder=1, folder=2, dot-file=3, file=4
        local function group_rank(e)
          if e.fs_type == "directory" then
            return is_special(e.name) and 1 or 2
          else
            return is_special(e.name) and 3 or 4
          end
        end
        -- 将字符串切成数字和非数字交替段，用于自然排序
        local function split_parts(str)
          local parts = {}
          local i = 1
          while i <= #str do
            local s, e = str:find("%d+", i)
            if s == i then
              table.insert(parts, str:sub(s, e))
              i = e + 1
            elseif s then
              table.insert(parts, str:sub(i, s - 1))
              i = s
            else
              table.insert(parts, str:sub(i))
              break
            end
          end
          return parts
        end

        table.sort(entries, function(a, b)
          -- 1) 分组比较
          local ga, gb = group_rank(a), group_rank(b)
          if ga ~= gb then
            return ga < gb
          end
          -- 2) 同组内先按扩展名排序
          local ea = a.name:match("%.[^%.]+$") or ""
          local eb = b.name:match("%.[^%.]+$") or ""
          if ea ~= eb then
            return ea < eb
          end
          -- 3) 再按自然数方式对名字排序
          local pa, pb = split_parts(a.name), split_parts(b.name)
          for i = 1, math.min(#pa, #pb) do
            local ca, cb = pa[i], pb[i]
            local na, nb = tonumber(ca), tonumber(cb)
            if na and nb then
              if na ~= nb then
                return na < nb
              end
            else
              local la, lb = ca:lower(), cb:lower()
              if la ~= lb then
                return la < lb
              end
            end
          end
          -- 前缀相同，短的靠前
          return #pa < #pb
        end)

        return entries
      end,
    },
    options = {
      -- Whether to delete permanently or move into module-specific trash
      permanent_delete = false,
    },
  },
}
