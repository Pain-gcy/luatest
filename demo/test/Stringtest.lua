--
-- Created by IntelliJ IDEA.
-- User: E470
-- Date: 2018/6/12
-- Time: 11:42
-- To change this template use File | Settings | File Templates.
-- convert numeric html entities to utf8

string1 = "Lua"
print("\"字符串 1 是\"",string1)
string2 = 'runoob.com'
print("字符串 2 是",string2)

string3 = [["Lua 教程"]]
print("字符串 3 是",string3)




function maximum (a)
    local mi = 1             -- 最大值索引
    local m = a[mi]          -- 最大值
    for i,val in ipairs(a) do
        if val > m then
            mi = i
            m = val
        end
    end
    return m, mi
end

print(maximum({8,10,23,12,5}))