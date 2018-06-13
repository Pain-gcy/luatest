--
-- Created by IntelliJ IDEA.
-- User: E470
-- Date: 2018/6/12
-- Time: 11:42
-- To change this template use File | Settings | File Templates.
-- convert numeric html entities to utf8

string1 = "Lua"
print("字符串 1 是",string1)
string2 = 'runoob.com'
print("字符串 2 是",string2)

string3 = [["Lua 教程"]]
print("字符串 3 是",string3)


string = "Lua Tutorial"
-- 查找字符串
print(string.find(string,"Tutorial"))
reversedString = string.reverse(string)
print("新的字符串为"..reversedString)

