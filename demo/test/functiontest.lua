--
-- Created by IntelliJ IDEA.
-- User: E470
-- Date: 2018/6/13
-- Time: 11:15
-- To change this template use File | Settings | File Templates.
--


--[[ 函数返回两个值的最大值 --]]
function max(num1, num2)

    if (num1 > num2) then
        result = num1;
    else
        result = num2;
    end
    return result;
end

-- 调用函数
print("两值比较最大值为 ", max(10, 4))
print("两值比较最大值为 ", max(5, 6))

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