
--
-- Player -------------------------------------------------
--

function init_player()
  player = {}
  player.w = ground.uw
  player.h = ground.uw * 2
  player.x = GW/2 - player.w/2
  player.y = GH/2 - player.h/2
  
  player.rx = function () return player.x + player.w/2 end
  player.ry = function () return player.y + player.h*1/4 end
  
  player.target = {}
  player.target.rx = function () return player.target.x + player.target.w/2 end 
  player.target.ry = function () return player.target.y - player.target.h*1/4 end 
  
  update_cell_player(player)
  
  player.vx = 0
  player.vy = 0 
  player.angle = 0
  anim_t = 0
  init_player_tools(player)
  player.current_tool = min(#player.tools, 1)
  ON_TOOLS = true
  
  init_inventory(player)
  
  player.target.to_draw = player.tools[player.current_tool].to_draw
  update_target()
  add_object_y_sort(player.target, draw_tool_target, - ground.uw/2)
  
  add_object_y_sort(player, draw_player, - player.h*1/2)
  
end

function init_inventory(p)
  p.inventory = {}
  
  add_item(p,0,0)

end

function count_inv(p)
  local c = 0
  for i, s in pairs(p.inventory) do
    if s.type ~= -1 then 
      c = c + 1
    end
  end
  return c
end


function find_item(p, type)
  local m
  local m_i
  for i, s in pairs(p.inventory) do
    if s.type == type then
      m   = m   or s.c
      m_i = m_i or i
      if s.c < m then 
        here()
        m_i = i 
      end
    end
  end
  return m_i
end

function add_item(p, type, c)
  if c < 1 then return end
  
  local slot = find_item(p,type)
 
  if not slot then
    p.inventory[count(p.inventory)] = {type = type, c = c}
  else
    p.inventory[slot].c = p.inventory[slot].c + c
  end
  
  
end

function update_player()

  local p = player
  -- MOVEMENT
  local acc = 16
  if btn("left")  then p.vx = min(0, p.vx - acc * dt()) end
  if btn("right") then p.vx = max(0, p.vx + acc * dt()) end
  
  if btn("up") then p.vy = min(0, p.vy - acc * dt())end
  if btn("down") then p.vy = max(0,p.vy + acc * dt()) end
  
  local mspd = 3
  -- circular mspd -----------------------
  player.angle = atan2(p.vx, p.vy)
  if dist(0, 0, p.vx, p.vy) > mspd then
    p.vx = cos(player.angle) * mspd
    p.vy = sin(player.angle) * mspd  
  end  
  -- -------------------------------------
  if (p.vx > .6 or p.vx < -.6) then 
    p.x = p.x + p.vx
  end
  if (p.vy > .6 or p.vy < -.6) then
    p.y = p.y + p.vy
  end
  p.x = mid(0, p.x, world_width() - p.w)
  p.y = mid(0, p.y, world_height() - p.h)
  
  local dec = .80
  p.vx = p.vx * dec
  p.vy = p.vy * dec
  
  if p.vx > .2 or p.vx < -.2 
  or p.vy > .2 or p.vy < -.2 then
    anim_t = anim_t + dt()
  end 
  update_cell_player(player)
  
  -- ACTION
  
  if btnp("e") then
    if ON_TOOLS then
      p.current_tool = 1 + (p.current_tool)%(#p.tools)
      p.target.to_draw = p.tools[p.current_tool].to_draw
    else
    
    end
  end
  if btnp("a") then
    if ON_TOOLS then
      p.current_tool = 1 + (p.current_tool-2)%(#p.tools)
      p.target.to_draw = p.tools[p.current_tool].to_draw
    else
    
    end
  end
  
  update_target()
  
  if btnp("action") then
    p.tools[p.current_tool].effect( p.target.x/ ground.uw + 1, p.target.y/ ground.uw + 1)
  end
  
  if _t_ids[p.current_tool] == "hand" then
    if btnp("action") then
      add_item(p,1, 1)
      
      log_inv(p)
      
    end
  end
  
  if btnp("change_tool") then
    ON_TOOLS = not ON_TOOLS
  end
  
end

function log_inv(p)
  for i, s in pairs(p.inventory) do 
    log("id = " .. s.type .. " count = " .. s.c)
  end

end

function update_cell_player(player)
  local x,y = player_cell_c(player)
  player.cell = {x, y}
end

_t_look_c = { -- template looking cells
  {0 , -1},
  {1 , 0},
  {0 , 1},
  {-1, 0 },
}

function draw_player()
  local p = player
  
  local stp  = .25/6
  local side = 0
  local a    = 0
  
  if p.vy < 0 then side = 1 end
    
  if p.vx > .2 or p.vx < -.2 
  or p.vy > .2 or p.vy < -.2 then
    a = -stp + (cos(anim_t*2)>0 and stp*2 or 0)
  end
  
  local x = p.x + p.w/2
  local y = p.y - p.h/4
  
  outlined(side, x, y, a, 1, 2) 
  
end

function outlined(spr, x, y, a, w, h)
  if not spr or not x or not y then return end
  
  local a = a or 0
  local w = w or 1
  local h = h or 1
  
  all_colors_to(_p_n("black"))
  aspr(spr, x - 1, y - 1, a, w, h) 
  aspr(spr, x - 1, y, a,     w, h) 
  aspr(spr, x - 1, y + 1, a, w, h) 
  
  aspr(spr, x,     y - 1, a, w, h) 
  aspr(spr, x,     y + 1, a, w, h) 
  
  aspr(spr, x + 1, y - 1, a, w, h) 
  aspr(spr, x + 1, y, a,     w, h) 
  aspr(spr, x + 1, y + 1, a, w, h) 
  
  
  all_colors_to()
  aspr(spr, x, y, a, w, h) 
  
end

function player_cell_c(player) return player_cell_x(player), player_cell_y(player) end
function player_cell_x(player) return flr((player.x + player.w/2)/ground.uw) end
function player_cell_y(player) return flr((player.y + player.h*1/4)/ground.uw) end



-- cra = {}
-- function cra()
  -- cra = {
    -- x = GW/2,
    -- y = GH/2,
    -- draw_cra = function () 
                -- rctf(cra.x, cra.y, 16, 16) 
                -- local x = cra.x + player.w/2
                -- local y = cra.y - player.h/4
                -- local stp  = .25/6
                -- local side = 0
                -- local a    = 0
                
                -- all_colors_to(_p_n("black"))
                -- aspr(16 + side, x - 1, y - 1, a, 1, 2) 
                -- aspr(16 + side, x - 1, y, a, 1, 2) 
                -- aspr(16 + side, x - 1, y + 1, a, 1, 2) 
                
                -- aspr(16 + side, x,     y - 1, a, 1, 2) 
                -- aspr(16 + side, x,     y + 1, a, 1, 2) 
                
                -- aspr(16 + side, x + 1, y - 1, a, 1, 2) 
                -- aspr(16 + side, x + 1, y, a, 1, 2) 
                -- aspr(16 + side, x + 1, y + 1, a, 1, 2) 
                
                
                -- all_colors_to()
                -- aspr(16 + side, x, y, a, 1, 2) 
              -- end
  -- }
  -- add_object_y_sort(cra, cra.draw_cra, - player.h*1/4)
-- end


-- function udpcra()
  -- cra.y = GH/2 + 32 * cos(time_since_launch / 16)
-- end


function update_target()
  local p = player
  
  -- if is_in(p.current_tool, tools_to_draw) then
    
  local ax = flr(p.angle * 100)/100
        ax = ax - 1/4
        ax = ax * 4
        ax = round(ax)
        ax = 1 + (ax + 2)%4
        
  p.target.x = (p.cell[1] + _t_look_c[ax][1]) * ground.uw
  p.target.y = (p.cell[2] + _t_look_c[ax][2]) * ground.uw
  p.target.w = ground.uw
  p.target.h = ground.uw
    
  -- end

end

function draw_tool_target()
  local p = player
  if p.target.to_draw then
    local x, y = p.target.x + 16/2, p.target.y + sin(time_since_launch) * 4 - 8
    outlined(16*2 + p.current_tool-1, x , y, 0)
  end

end




