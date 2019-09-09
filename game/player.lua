
--
-- Player -------------------------------------------------
--

function init_player()
  player = {}
  player.w = ground.uw
  player.h = ground.uw * 2
  player.x = GW/2 - player.w/2
  player.y = GH/2 - player.h/2
  
  player.vx = 0
  player.vy = 0 
  anim_t = 0
end

function update_player()
  local p = player
  local acc = 16
  if btn("left")  then p.vx = min(0, p.vx - acc * dt()) end
  if btn("right") then p.vx = max(0, p.vx + acc * dt()) end
  
  if btn("up")   then p.vy = min(0, p.vy - acc * dt()) end
  if btn("down") then p.vy = max(0,p.vy + acc * dt()) end
  
  local mspd = 3
  -- circular mspd -----------------------
  local a = atan2(p.vx, p.vy)
  if dist(0, 0, p.vx, p.vy) > mspd then
    p.vx = cos(a) * mspd
    p.vy = sin(a) * mspd  
  end  
  -- -------------------------------------
  
  p.x = p.x + p.vx
  p.y = p.y + p.vy
  
  p.x = mid(0, p.x, world_width() - p.w)
  p.y = mid(0, p.y, world_height() - p.h)
  
  
  local dec = .80
  p.vx = p.vx * dec
  p.vy = p.vy * dec
  
  if p.vx > .2 or p.vx < -.2 
  or p.vy > .2 or p.vy < -.2 then
    anim_t = anim_t + dt()
  end 

  
end

-- P_HEAD_L = 14 

function draw_player()
   
  local stp  = .25/6
  local side = 0
  local a    = 0
  
  if player.vy < 0 then side = 1 end
    
  if player.vx > .2 or player.vx < -.2 
  or player.vy > .2 or player.vy < -.2 then
    a = -stp + (cos(anim_t*2)>0 and stp*2 or 0)
  end
  
  all_colors_to(_p_n("black"))
  aspr(16 + side, player.x - 1, player.y - 1, a, 1, 2) 
  aspr(16 + side, player.x - 1, player.y, a, 1, 2) 
  aspr(16 + side, player.x - 1, player.y + 1, a, 1, 2) 
  
  aspr(16 + side, player.x, player.y - 1, a, 1, 2) 
  aspr(16 + side, player.x, player.y + 1, a, 1, 2) 
  
  aspr(16 + side, player.x + 1, player.y - 1, a, 1, 2) 
  aspr(16 + side, player.x + 1, player.y, a, 1, 2) 
  aspr(16 + side, player.x + 1, player.y + 1, a, 1, 2) 
  
  
  all_colors_to()
  aspr(16 + side, player.x, player.y, a, 1, 2) 
  
end

function player_cell_c() return player_cell_x(), player_cell_y() end
function player_cell_x() return flr((player.x + player.w*3/4)/ground.uw) end
function player_cell_y() return flr((player.y + player.h/2)/ground.uw) end



















