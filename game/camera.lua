
--
-- Camera -------------------------------------------------
--

function init_camera()
  
end

function update_camera()
  
end

function cam_on_player()
  
  local cx, cy = get_camera()
  
  local tx = player.x + player.w/2 - GW/2
  local ty = player.y + player.h/2 - GH/2
  
  cx = cx + (tx - cx) * .2
  cy = cy + (ty - cy) * .2
  
  cx = mid(0, cx, ground.w * ground.uw - GW)
  cy = mid(0, cy, ground.h * ground.uw - GH)
  
  camera(cx, cy)
  
end