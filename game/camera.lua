
--
-- Camera -------------------------------------------------
--

local ox, oy

function init_camera()
  ox = 0
  oy = 0
  camera(ox, oy)
end

function update_camera()
  
end

function cam_on_player()
  
  local tx = player.rx() - GW/2
  local ty = player.ry() - GH/2
  
  local dx = (tx - ox) * .2
  local dy = (ty - oy) * .2
  
  dx = (mid(0, ox + dx, ground.w * ground.uw - GW) == ox + dx) and dx or 0
  dy = (mid(0, oy + dy, ground.h * ground.uw - GH) == oy + dy) and dy or 0
  
  ox = ox + dx
  oy = oy + dy
  
  camera(ox, oy)
  
end