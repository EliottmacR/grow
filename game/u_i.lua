
--
-- ui -------------------------------------------------
--

ui_e = {}
function init_ui()
  ui_e = {{}, {}, {}, {}}
  add(ui_e[1], new_tool_ui())
  
  add(ui_e[2], new_inv_bar_ui())
  
end

function update_ui()
  for i = 1, #ui_e do
    for i, e in pairs(ui_e[i]) do
      e:update()
    end
  end
end

function draw_ui()
  for i = 1, #ui_e do
    for i, e in pairs(ui_e[i]) do
      e:draw()
    end
  end
  -- ui_e[1][1].draw()
end


--
-- Tool ui --------------------------------------------
--

function new_tool_ui()

	local e = {}
	e.w = 16 + 3
	e.h = 16 + 3

	e.x = 0
	e.y = GH - e.h
  
  -- e.uiy = 0
  
	e.update = update_tool_ui
	e.draw = draw_tool_ui

  return e
end


function update_tool_ui(e)


end

function draw_tool_ui(e)

  rctf(e.x, e.y-1, e.w, e.h, _p_n("black"))
  
  rct (e.x, e.y-1, e.w, e.h, (ON_TOOLS) and _p_n("p_blue") or _p_n("white"))

  -- rctf(e.x+2, e.y, 16, 16, _p_n("p_red"))
  
  
  aspr(16*2 + player.current_tool-1, e.x + 2 + 16/2, e.y + 16/2 + 1, 0) 
end





--
-- inv bar ui --------------------------------------------
--


function new_inv_bar_ui()

	local e = {}
	e.w = (16 + 3) * 6 + 1
	e.h = 16 + 3

	e.x = GW - e.w
	e.y = GH - e.h
  
  e.inv_y = 0
  e.inv_x = 0
  
	e.update = update_inv_ui
	e.draw = draw_inv_ui

  return e
end

function update_inv_ui(e)
  there()
  if not ON_TOOLS then
    if btnp("a") then
      here()
    elseif btnp("e") then
      there()
    end
  end

end

function draw_inv_ui(e)

  rctf(e.x, e.y-1, e.w, e.h, _p_n("black"))
  
  rct (e.x, e.y-1, e.w-1, e.h, (not ON_TOOLS) and _p_n("p_blue") or _p_n("white"))
  
  local x = e.x
  local y = e.y - 1
  
  for i = 1, 5 do
    line(x + i * (e.w-1) /6, y, x + i * (e.w-1) /6, y + e.h)
  end
  
  x = x + 16/2 + 2
  y = y + 16/2 + 2
  
  local p = player
  
  for i = 1, min(count_inv(p), 6) do
    aspr(16*2 + player.current_tool-1, 
    x + (i-1) * (e.w-1)/6,
    y,
    0) 
  end
  
end


























