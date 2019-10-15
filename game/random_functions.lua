function count(tab)
  if not tab then return 0 end
  local nb = 0
  for i, j in pairs(tab) do nb = nb + 1 end
  return nb  
end

function mouse_in_rect( x1, y1, x2, y2, mx, my)
  if not x1 or not y1 or not x2 or not y2 then return end
  local mx = mx or btnv(2)
  local my = my or btnv(3)
  return mx > x1 and mx < x2 and my > y1 and my < y2
end

function point_in_rect(x, y, x1, y1, x2, y2)
  return x > x1 and x < x2 and y > y1 and y < y2
end

function chance(x) -- x gotta be between between 1 and 100 (both in)
  if x > 100 or x < 0 then return end
  return (rnd(100) <= x)
end

function here() log("here") end
function there() log("there") end

function easeInOut (timer, value_a, value_b, duration)
  
  timer = timer/duration*2  
	if (timer < 1) then return value_b/2*timer*timer + value_a end  
	timer = timer - 1  
 	return -value_b/2 * (timer*(timer-2) - 1) + value_a
end

function point_in_rect(x, y, x1, y1, x2, y2)
  return x > x1 and x < x2 and y > y1 and y < y2
end

function pick_distinct( amount, from )
  if not from or not amount or from == {} then return {} end
  
  to_return = {}  
  for i = 1, amount do
    local choosen = pick(from)    
    while check_in(choosen, to_return) do 
      choosen = pick(from)
    end
    add(to_return, choosen)    
  end
  
  return to_return
end

function is_in(value, tab)
  for index, val in pairs(tab) do
    if val == value then return true end
  end
  return false
end

function sign(x) return x >=0 and 1 or -1 end

function rct(x, y, w, h, col)
  return rect(x, y, x + w, y + h, col)
end
function rctf(x, y, w, h, col)
  return rectfill(x, y, x + w, y + h, col)
end



function copy(obj)
  if type(obj) ~= 'table' then return obj end
  local res = {}
  for k, v in pairs(obj) do res[copy(k)] = copy(v) end
  return res
end




