local _ = require "underscore"
time ={59796575}
distance ={597123410321328}
-- time={7,15,30}
-- distance = { 9,  40, 200}
local wins = {}
while(not _.is_empty(time)) do
    local t = _.shift(time)
    local d= _.shift(distance)
    win = 0
    _.range(1,t-1):each(function(i)
      if (i*(t-i))>d then
        win = win+1
      end
    end)
    print(win)
    _.push(wins,win)
end
print(_.reduce(wins,1,function(a,b) return a*b end))
