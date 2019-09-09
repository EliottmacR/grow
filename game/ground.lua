

--
-- Ground -------------------------------------------------
--

function world_width()  return ground.w * ground.uw end
function world_height() return ground.h * ground.uw end

function init_ground()
  ground = {}
  ground.uw = 16 -- unit width
  ground.w = 25
  ground.h = 25
  
  ground.cells = {}
  
  for j = 0, ground.h do
    local l = {}
    for i = 0, ground.w do 
      add(l, new_cell(i, j))
    end
    add(ground.cells, l)
  end
end

function update_ground()

  local g = ground
  local px, py = player_cell_c()  
  local from_y = py - flr((GH)/g.uw)
  local from_x = px - flr((GW)/g.uw)
  
  for j = max(1, from_y), min(from_y + flr((GH)/g.uw)*2, g.h)  do 
    for i = max(1, from_x), min(from_x + flr((GW)/g.uw)*2, g.w)  do 
      g.cells[j][i]:update()
    end
  end
end

function draw_ground()

  local g = ground
  local px, py = player_cell_c()  
  local from_y = py - flr((GH)/g.uw)
  local from_x = px - flr((GW)/g.uw)
  
  for j = max(1, from_y), min(from_y + flr((GH)/g.uw)*2, g.h)  do 
    for i = max(1, from_x), min(from_x + flr((GW)/g.uw)*2, g.w)  do 
      g.cells[j][i]:draw()
    end
  end
end

function new_cell(x, y)
  local cell = {
    x = x,
    y = y,
    type = 0,
    update = update_cell,
    draw = draw_cell,  
  }  
  return cell
end

function update_cell(cell)

end

function draw_cell(cell)
  local x = cell.x*ground.uw
  local y = cell.y*ground.uw
  spr(cell.type, x, y)
end







