local _NyKmwQhqNtcv = table.concat
local _ivGqTenJUaU = string.byte
local _niMPKIWaqNjeQdDh = string.char
local _olbHzdiXtGvkqOvC = error
local _duDAqpESVLLm = type

local function _Packet(_BiBJpxmVgq)
    local _FMacdqJrkLpoNWNay, _zebvfafyybKQak = 136132, 136132 + 17

    for _yfYWjiMlVwFQsMaH = 1, #_BiBJpxmVgq do
        local _DwBUQyKuBKOmOTt = _BiBJpxmVgq[_yfYWjiMlVwFQsMaH]
        _FMacdqJrkLpoNWNay = (_FMacdqJrkLpoNWNay * 131 + _DwBUQyKuBKOmOTt) % 2147483647
        _zebvfafyybKQak = (_zebvfafyybKQak * 257 + _DwBUQyKuBKOmOTt) % 2147483629
    end

    if _FMacdqJrkLpoNWNay ~= 1167002746 or _zebvfafyybKQak ~= 581518700 then
        _olbHzdiXtGvkqOvC("LuaVault: integrity check failed", 0)
    end

    return true
end

local function _Constant(_pYtKUSTtVnzDAnQc, _AYVrANgXkq)
    local _lIInlJFHFf, _jEnpybDCYxzy, _VwrMqXlEeJBL = _AYVrANgXkq[1], _AYVrANgXkq[2], _AYVrANgXkq[3]
    local _NgZZkCJYEjMlE = _AYVrANgXkq[6]
    local _aLAvpDsMZp, _nzjYaArFhlCqVrVF = 997, 1013
    local _vTvGggvOHUImHLvDhy = {
        _pYtKUSTtVnzDAnQc,
        _lIInlJFHFf,
        _jEnpybDCYxzy,
        _VwrMqXlEeJBL,
        #_NgZZkCJYEjMlE
    }

    for _RZLFKcqUIKizibFjo = 1, 5 do
        _aLAvpDsMZp = (_aLAvpDsMZp * 131 + _vTvGggvOHUImHLvDhy[_RZLFKcqUIKizibFjo]) % 2147483647
        _nzjYaArFhlCqVrVF = (_nzjYaArFhlCqVrVF * 257 + _vTvGggvOHUImHLvDhy[_RZLFKcqUIKizibFjo]) % 2147483629
    end

    local _atfXLXlIIlvBeV = {}

    for _RZLFKcqUIKizibFjo = 1, #_NgZZkCJYEjMlE do
        local _ivGqTenJUaU = _ivGqTenJUaU(_NgZZkCJYEjMlE, _RZLFKcqUIKizibFjo)
        local _DwBUQyKuBKOmOTt = (_ivGqTenJUaU - _lIInlJFHFf % 256 - (_RZLFKcqUIKizibFjo * _VwrMqXlEeJBL) % 256) % 256

        _lIInlJFHFf = (_lIInlJFHFf * _jEnpybDCYxzy + _ivGqTenJUaU + _VwrMqXlEeJBL) % 2147483647
        _aLAvpDsMZp = (_aLAvpDsMZp * 131 + _DwBUQyKuBKOmOTt + _RZLFKcqUIKizibFjo) % 2147483647
        _nzjYaArFhlCqVrVF = (_nzjYaArFhlCqVrVF * 257 + _DwBUQyKuBKOmOTt + _RZLFKcqUIKizibFjo) % 2147483629
        _atfXLXlIIlvBeV[_RZLFKcqUIKizibFjo] = _niMPKIWaqNjeQdDh(_DwBUQyKuBKOmOTt)
    end

    if _aLAvpDsMZp ~= _AYVrANgXkq[4] or _nzjYaArFhlCqVrVF ~= _AYVrANgXkq[5] then
        _olbHzdiXtGvkqOvC("LuaVault: constant integrity check failed", 0)
    end

    return _NyKmwQhqNtcv(_atfXLXlIIlvBeV)
end

local function _nTyWNHAuTnxoHvfchu(_FJjIQizophdHPmxMHR)
    local _aLAvpDsMZp, _nzjYaArFhlCqVrVF = 997, 1013

    local function _CEXTYzJordGmjGKu(_xjzbXGPDmrZjxK)
        if _duDAqpESVLLm(_xjzbXGPDmrZjxK) ~= "number" then
            _olbHzdiXtGvkqOvC("LuaVault: prototype integrity check failed", 0)
        end

        _aLAvpDsMZp = (_aLAvpDsMZp * 131 + _xjzbXGPDmrZjxK) % 2147483647
        _nzjYaArFhlCqVrVF = (_nzjYaArFhlCqVrVF * 257 + _xjzbXGPDmrZjxK) % 2147483629
    end

    _CEXTYzJordGmjGKu(_FJjIQizophdHPmxMHR._NSfESDYHYv)
    _CEXTYzJordGmjGKu(_FJjIQizophdHPmxMHR._gtKNgnkwTOJWDYVrk)
    _CEXTYzJordGmjGKu(_FJjIQizophdHPmxMHR._dXpcIxRXBI)
    _CEXTYzJordGmjGKu(_FJjIQizophdHPmxMHR._WniwXGqLcBC)
    _CEXTYzJordGmjGKu(_FJjIQizophdHPmxMHR._YelomqBlISxblDJ)
    _CEXTYzJordGmjGKu(_FJjIQizophdHPmxMHR._wNWDDHRdvFpBv)
    _CEXTYzJordGmjGKu(_FJjIQizophdHPmxMHR._wTkYfZitBpCXJoJmHJ)
    _CEXTYzJordGmjGKu(_FJjIQizophdHPmxMHR._GhnZmKttDqUoz)
    _CEXTYzJordGmjGKu(_FJjIQizophdHPmxMHR._PYfpJYoXnBejXpbb)

    _CEXTYzJordGmjGKu(#_FJjIQizophdHPmxMHR._exOzvdTPYJyTT)
    for _RZLFKcqUIKizibFjo = 1, #_FJjIQizophdHPmxMHR._exOzvdTPYJyTT do
        _CEXTYzJordGmjGKu(_FJjIQizophdHPmxMHR._exOzvdTPYJyTT[_RZLFKcqUIKizibFjo])
    end

    _CEXTYzJordGmjGKu(#_FJjIQizophdHPmxMHR._zaAqBKUQpKMtHvzndb)
    for _RZLFKcqUIKizibFjo = 1, #_FJjIQizophdHPmxMHR._zaAqBKUQpKMtHvzndb do
        _CEXTYzJordGmjGKu(_FJjIQizophdHPmxMHR._zaAqBKUQpKMtHvzndb[_RZLFKcqUIKizibFjo][1])
        _CEXTYzJordGmjGKu(_FJjIQizophdHPmxMHR._zaAqBKUQpKMtHvzndb[_RZLFKcqUIKizibFjo][2])
    end

    _CEXTYzJordGmjGKu(_FJjIQizophdHPmxMHR._JxdDhfBxXYudg)
    _CEXTYzJordGmjGKu(#_FJjIQizophdHPmxMHR._DwrmACLvupmy)
    _CEXTYzJordGmjGKu(#_FJjIQizophdHPmxMHR._meenqKMaYLpoZUshu)

    for _RZLFKcqUIKizibFjo = 1, 6 do
        _CEXTYzJordGmjGKu(_FJjIQizophdHPmxMHR._uaInTxjJeodaVbB[_RZLFKcqUIKizibFjo])
    end

    return _aLAvpDsMZp, _nzjYaArFhlCqVrVF
end

local function _Prototype(_FJjIQizophdHPmxMHR)
    local _aLAvpDsMZp, _nzjYaArFhlCqVrVF = _nTyWNHAuTnxoHvfchu(_FJjIQizophdHPmxMHR)

    if _aLAvpDsMZp ~= _FJjIQizophdHPmxMHR._GVDTsUMfjCMqtQg or _nzjYaArFhlCqVrVF ~= _FJjIQizophdHPmxMHR._lodkSituVIVseWDs then
        _olbHzdiXtGvkqOvC("LuaVault: prototype integrity check failed", 0)
    end

    return true
end

local function _Instruction(_FJjIQizophdHPmxMHR, _UNmoTGEmDuXlaWFFxw, _LxapxPXpDWLEeNR, _kXeKuXKvcyJZuh)
    local _aLAvpDsMZp = (_FJjIQizophdHPmxMHR._GhnZmKttDqUoz + _UNmoTGEmDuXlaWFFxw + _LxapxPXpDWLEeNR) % 2147483647
    local _nzjYaArFhlCqVrVF = (_FJjIQizophdHPmxMHR._GhnZmKttDqUoz + _UNmoTGEmDuXlaWFFxw + _LxapxPXpDWLEeNR + 17) % 2147483629

    for _lAeRzwfXYSq = 1, 6 do
        local _xjzbXGPDmrZjxK = _kXeKuXKvcyJZuh[_lAeRzwfXYSq]
        if _duDAqpESVLLm(_xjzbXGPDmrZjxK) ~= "number" then
            _olbHzdiXtGvkqOvC("LuaVault: instruction integrity check failed", 0)
        end

        _aLAvpDsMZp = (_aLAvpDsMZp * 131 + _xjzbXGPDmrZjxK + _lAeRzwfXYSq) % 2147483647
        _nzjYaArFhlCqVrVF = (_nzjYaArFhlCqVrVF * 257 + _xjzbXGPDmrZjxK + _lAeRzwfXYSq) % 2147483629
    end

    if _aLAvpDsMZp ~= _kXeKuXKvcyJZuh[7] or _nzjYaArFhlCqVrVF ~= _kXeKuXKvcyJZuh[8] then
        _olbHzdiXtGvkqOvC("LuaVault: instruction integrity check failed", 0)
    end

    return true
end

return {
    Packet = _Packet,
    Constant = _Constant,
    Prototype = _Prototype,
    Instruction = _Instruction,
    print("Ai slop")
}
