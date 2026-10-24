do -- old
    local a = "ndKvWRnSKYzhBhualx_"
    local b = "SIOyDNtDoX"
    local c = "\215\253Pm\201R\197\183\225rYU\177\157\2477"

    local function d()
        error("MoonVeil environment integrity check failed", 0)
    end

    local function e(f)
        if type(f) ~= "string" then d() end
        return f:find(a, 1, true) ~= nil
    end

    local function g(h)
        local i, j = pcall(function() h() end)
        if i or e(j) then d() end
    end

    local function k(l, m, n, o)
        local p, q = pcall(function()
            if l[m] and #c == n then end
            if l[a] then end
        end)
        if p then
            if o then d() end
            return
        end
        if not e(q) then d() end
    end

    if game == nil or Enum == nil then d() end
    g(game)
    k(game, "GetService", 16, false)
    k(game, "workspace", 16, false)
    g(Enum)
    k(Enum, "Font", 32, true)
    k(Enum, "Material", 32, false)

    if type(debug) ~= "table" or type(debug.traceback) ~= "function" or type(debug.info) ~= "function" then d() end

    local r = debug.traceback(b)
    if type(r) ~= "string" then d() end

    local s = r:find("\n", 1, true)
    if s == nil then d() end

    local t = r:sub(1, s - 1)
    local u = r:gmatch(":(%d*)\n")
    local v = u()
    local w = 1
    for x in u do
        local _ = v ~= x and w < 2
        w = w + 1
    end

    local y = debug.info(1, "l")
    if type(y) ~= "number" and type(y) ~= "string" then d() end

    local _ = t == b and w >= 2 and v == "" .. y
end
