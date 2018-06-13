local message = "您已购买该产品，有效期内将不能再次订购"
local chunk = ngx.arg[1]
ngx.log(ngx.ERR, "走到了lua" .. chunk)
if string.match(chunk, "code") then
    local cjson = require("cjson")
    cjson.encode_empty_table_as_object(false)
    local bodyJson = cjson.decode(ngx.arg[1])
    local code = bodyJson.code
    if code == "A000000" then
        local result = bodyJson["data"]["result"]
        ngx.log(ngx.ERR,result .. type(result) .. "鉴权结果")
        if result == 0 then
            bodyJson["message"] = message
            ngx.arg[1] = cjson.encode(bodyJson)
            return
        end
    end
end