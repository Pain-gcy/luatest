
ngx.log(ngx.ERR, "河南分省统一订购start")
local JSON = require "json_n"
local cjson = require "cjson"
function auth()
    ngx.req.read_body()
    args = ngx.req.get_body_data()
    local data = cjson.decode(args);
    ngx.log(ngx.ERR, type(data) .. "args的类型")
    if next(data) == nil then
	ngx.log(ngx.ERR, "获取接口参数失败")
        ngx.exit(400)
    end
    local mac = data["mac"]
    local userId = data["userId"]
    local contentId = data["contentId"]
    local userToken = data["userToken"]
    local productId = data["productId"]
    local contentName = data["contentName"]
    local payType  = data["payType"]
    local epgServer  = data["epgServer"]
    local partnerCode  = data["partnerCode"]



    if userId == nil or mac == nil or contentId == nil or userToken == nil or productId == nil or payType == nil or epgServer == nil then
        ngx.exit(400)
    end

    local params = '{"mac": "' .. mac .. '" ,"userId": "' .. userId .. '","productId":"' .. productId .. '","contentId": "' .. contentId .. '","payType":"' .. payType .. '","userToken": "' .. userToken .. '","albumName": "' .. contentName .. '","chnId":"' .. contentId .. '","tvId":"' .. contentId .. '","tvName":"' .. contentName .. '","epgServer":"' .. epgServer .. '","partnerCode":"' .. partnerCode .. '","albumId":"' .. contentId .. '"}'
    ngx.log(ngx.ERR, "请求入参" .. params)
    local res = ngx.location.capture("/v1/account/order/", { method = ngx.HTTP_POST, body = params });
    ngx.log(ngx.ERR, "调用结束" .. res.status)
    ngx.log(ngx.ERR, res.body)
    if 200 ~= res.status then
        ngx.exit(res.status)
    end
    local rspData = JSON:decode(res.body)
    ngx.log(ngx.ERR, "响应类型" .. type(rspData))
    return JSON:encode(rspData)
end





local status, retval = pcall(auth)
if not status then
    ngx.log(ngx.ERR, "啊哦~程序出错了...:" .. retval)
end
ngx.say(retval)
