--
-- Created by IntelliJ IDEA.
-- User: GuoChunyuan
-- Date: 2018/06/12
-- Time: 16:13
-- To change this template use File | Settings | File Templates.
--

local result = [[
{
    "code": "A000000",
    "data": {
        "productList":[],
        "result": %d,
        "playUrl":"%s",
        "desc":"%s"
    },
    "message": "%s",
    "timestamp": "%s"
}
]]
local MESSAGE = "由于您未订购VIP影片，暂时无法观看\n如需订购VIP影片，请前往中国移动营业厅办理付费业务。"

local cjson = require "cjson"

function authRes()
    ngx.req.read_body()
    local data = ngx.req.get_body_data()
    local args = cjson.decode(data)
    if args ~= nil and args ~= "" then
        local userId = args["userId"]
        --        local mac = args["mac"]
        local userToken = args["userToken"]
        local epgServer = args["epgServer"]
        local cid = args["contentId"]
        local superCid = (nil == args["superCid"]) and -2 or args["superCid"]
        if userId == nil or epgServer == nil or cid == nil then
            ngx.exit(400)
        end
        local params = '{"userid": "' .. userId .. '","cid": "' .. cid .. '","supercid": "' .. superCid .. '","businessType": "1","tid": "-1","playType": "1","contentType": "0","idflag": "1", }'
        --        ngx.log(ngx.ERR, "请求参数:" .. params)
        ngx.req.set_header("Authorization", userToken)
        local res = ngx.location.capture("/v0/accountlua/auth/" .. epgServer, { method = ngx.HTTP_POST, body = params });
        --        ngx.log(ngx.ERR, "调用结束" .. res.status)
        --        ngx.log(ngx.ERR, res.body)
        if 200 ~= res.status then
            ngx.exit(res.status)
        end
        return string.format("%s", jsonResult(res.body))
    else
        ngx.exit(400)
    end
end

function jsonResult(data)
    local rspData = cjson.decode(data)
    local returncode = rspData["returncode"]
    if returncode == "0" then --鉴权成功
        local urls = rspData["urls"]
        local url = "";
        for _, w in ipairs(urls) do
            url = w["playurl"]
        end
        --        ngx.log(ngx.ERR, "播放url" .. url)
        return string.format(result, "0", url, "", "", os.date("%Y%m%d%H%M%S", os.time()))
    else
        --        local productlist = rspData["productlist"]
        --ngx.log(ngx.ERR,"可订购列表"..productlist)
        return string.format(result, 1, "", "", MESSAGE, os.date("%Y%m%d%H%M%S", os.time()))
    end
end

local status, retval = pcall(authRes)
if not status then
    ngx.log(ngx.ERR, "error: " .. retval)
end
ngx.say(retval)
ngx.exit(ngx.HTTP_OK)




