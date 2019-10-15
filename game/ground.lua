

--
-- Ground -------------------------------------------------
--

function world_width()  return ground.w * ground.uw end
function world_height() return ground.h * ground.uw end

function init_ground()
  ground = {}
  ground.uw = 16 -- unit width
  ground.w = 75
  ground.h = 75
  
  ground.cells_t = {}
  ground.cells_o = {}
  
  for j = 0, ground.h do
    local l = {}
    for i = 0, ground.w do 
      add(l, new_cell(i, j))
    end
    add(ground.cells_t, l)
  end
  init_spr_ground()
  
end

function update_ground()

  local g = ground
  local px, py = player_cell_c()  
  local from_y = py - flr((GH)/g.uw)
  local from_x = px - flr((GW)/g.uw)
  
  for j = max(1, from_y), min(from_y + flr((GH)/g.uw)*2, g.h)  do 
    for i = max(1, from_x), min(from_x + flr((GW)/g.uw)*2, g.w)  do 
      g.cells_t[j][i]:update()
    end
  end
end

function draw_ground()

  local g = ground
  local c = player.cell
  local from_x = c[1] - flr((GW)/g.uw)
  local from_y = c[2] - flr((GH)/g.uw)
  
  for j = max(1, from_y), min(from_y + flr((GH)/g.uw)*2, g.h)  do 
    for i = max(1, from_x), min(from_x + flr((GW)/g.uw)*2, g.w)  do 
      g.cells_t[j][i]:draw()
    end
  end
  
  local p = player
  -- if p.target.to_draw then
  rct(p.target.x, p.target.y, p.target.w, p.target.h, p.target.to_draw and _p_n("p_blue") or _p_n("swhite") )
  -- end
  
end

--
-- Cells ----------------------------
--

function new_cell(x, y)
  local cell = {
    x = x,
    y = y,
    type = 1,
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
  
  spr(get_state_from_cell(cell), x, y)
end

function init_spr_ground()
  spr_state = {}
  for j = 0, ground.h do
    local l = {}
    for i = 0, ground.w do 
      add(l, 1)
    end
    add(spr_state, l)
  end
  
  --   2    7  8  9  16 17 18
  -- 3 4 5 10 11 12  19  1 20
  --   6   13 14 15  21 22 23
  
  local dirt_states = { -- state to x,y on spr_sheet
    {8,2},
    
          {2,1},
    {1,2},{2,2},{3,2},
          {2,3},
          
    {4,1},{5,1},{6,1},
    {4,2},{5,2},{6,2},
    {4,3},{5,3},{6,3},
          
    {7,1},{8,1},{9,1},
    {7,2},      {9,2},
    {7,3},{8,3},{9,3},
  }
  
  local gd_states = copy(dirt_states)
  
  for i, c in pairs(gd_states) do 
    c[2] = c[2] + 3
  end
  
  ground_types = {
    "default",
    "field_dirt",
    "garden_dirt",
  }
  
  states = {} -- [type] = tabs of {value : x,y in spr sheet}
  states[ground_types[1]] = {{1,1}}    
  states[ground_types[2]] = dirt_states
  states[ground_types[3]] = gd_states  
  
end


function get_state_from_cell(cell)
  if spr_state[cell.y+1] and spr_state[cell.y+1][cell.x+1] then
    return state_to_spr(spr_state[cell.y+1][cell.x+1], cell.type)
  end
end


function state_to_spr(state, type)
  return ground_xy_to_spr(states[ground_types[type]][state])
end

function ground_xy_to_spr(tile)
  if not tile then return end
  local x = tile[1]
  local y = tile[2]

  return 16*(2 + y) + (x - 1)
end

function update_tile_state(cell, makes_calls)
  local x = cell.x + 1
  local y = cell.y + 1
  local makes_calls = makes_calls or false
  
  --   2    7  8  9  16 17 18
  -- 3 4 5 10 11 12  19  1 20
  --   6   13 14 15  21 22 23
  
  local np = list_of_neigbors_p(cell.type,x,y)
  local nx = list_of_neigbors_x(cell.type,x,y)
  local countp = #np
  local countx = #nx
  
  local u = is_in(1, np)
  local r = is_in(2, np)
  local d = is_in(3, np)
  local l = is_in(4, np)
  
  local ul = is_in(1, nx)
  local ur = is_in(2, nx)
  
  local dr = is_in(3, nx)
  local dl = is_in(4, nx)
  
  spr_state[y][x] = 1  
  
  --   2    7  8  9  16 17 18
  -- 3 4 5 10 11 12  19  1 20
  --   6   13 14 15  21 22 23
  if cell.type ~= 1 then
    if u then
      if l then
        if d then
          if r then
            if countx > 0 then spr_state[y][x] = 1 else spr_state[y][x] = 4 end
          else
            spr_state[y][x] = 20
          end
        else
          if r then
            spr_state[y][x] = 22
          else
            if countx > 0 then spr_state[y][x] = 23 else spr_state[y][x] = 15 end
          end
        end
      elseif d then
        if r then
          spr_state[y][x] = 19
        else
          spr_state[y][x] = 10
        end
      elseif r then
        if countx > 0 then spr_state[y][x] = 21 else spr_state[y][x] = 13 end
      else
        spr_state[y][x] = 6
      end
    elseif l then
      if d then
        if r then 
          spr_state[y][x] = 17 
        else 
          if countx > 0 then spr_state[y][x] = 18 else spr_state[y][x] = 9 end
        end
      elseif r then
        spr_state[y][x] = 14
      else 
        spr_state[y][x] = 5
      end
    elseif d then
      if r then
        if countx > 0 then spr_state[y][x] = 16 else spr_state[y][x] = 7 end
      else
        spr_state[y][x] = 2
      end
    elseif r then
      spr_state[y][x] = 3
    else
      spr_state[y][x] = 11
    end
  end
  
  if makes_calls then
    for j = -1, 1 do
      for i = -1, 1 do
        local x = x + i
        local y = y + j
        if ground.cells_t[y] and ground.cells_t[y][x] then 
          if not (i == 0 and j ==0 ) then
            update_tile_state(ground.cells_t[y][x])
          end
        end
      end
    end
  end
  
  
end

function list_of_neigbors_p(type,x,y)
  local _t_look_c = { -- template looking cells
          {0 , -1},
          {1 , 0},
          {0 , 1},
          {-1, 0 },
        }
        
  local l = {}
  for i, c in pairs(_t_look_c) do
    if ground.cells_t[c[2]+y] and ground.cells_t[c[2]+y][c[1]+x] and ground.cells_t[c[2]+y][c[1]+x].type == type then
      add(l, i)
    end
  end
  return l
end

function list_of_neigbors_x(type,x,y)
  local _t_look_c = { -- template looking cells
          {-1, -1},
          {1 , -1},
          {1 ,  1},
          {-1,  1},
        }
  local l = {}
  for i, c in pairs(_t_look_c) do
    if ground.cells_t[c[2]+y] and ground.cells_t[c[2]+y][c[1]+x] and ground.cells_t[c[2]+y][c[1]+x].type == type then
      add(l, i)
    end
  end
  return l
end









