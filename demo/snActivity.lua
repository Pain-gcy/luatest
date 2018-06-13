--ngx.log(ngx.ERR, "陕西抽奖活动开始_lua")

local result = [[
{
    "code": "A000000",
    "data": {
        "result": "%s"
    },
    "message": "",
    "timestamp": "%s"
}
]]


local JSON = require "json_n"
function authRes()
    local args = ngx.req.get_uri_args()
    if args ~= nil and args ~= "" then
        local userId = args["userId"]
        local mac = args["mac"]
        local userToken = args["userToken"]
        local epgServer = args["epgServer"]
        local pcallback = args["pcallback"]
        if userId == nil then
            ngx.exit(400)
        end
        local params = '{"mac": "' .. mac .. '" ,"userId": "' .. userId .. '","userToken": "' .. userToken .. '","epgServer": "' .. epgServer .. '","isEffective": "' .. 1 .. '","pageNo": "' .. 1 .. '","pageSize": "' .. 10 .. '", }'
        local res = ngx.location.capture("/v1/account/orderRecQuery/", { method = ngx.HTTP_POST, body = params });
	--ngx.log(ngx.ERR, "调用结束" .. res.status)
        if 200 ~= res.status then
            ngx.exit(res.status)
        end
        return string.format("%s(%s)", pcallback, jsonResult(res.body))
    else
        ngx.exit(400)
    end
end


function jsonResult(data)
    local rspData = JSON:decode(data)
    local product = rspData["data"]["list"]
    if product ~= nil and product ~= "" then
        return string.format(result, 0, os.date("%Y%m%d%H%M%S", os.time()))
    else
        return string.format(result, 1, os.date("%Y%m%d%H%M%S", os.time()))
    end
end


local status, retval = pcall(authRes)
if not status then
    ngx.log(ngx.ERR, "啊哦~程序出错了...:" .. retval)
end
ngx.say(retval)
ngx.exit(ngx.HTTP_OK)
