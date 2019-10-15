
--
-- Tools
--

_t_ids = {}
_t_fs = {}
tools_to_draw = {}

function init_tools()
  _t_ids = {}
  _t_fs = {}

  add(_t_ids, "hand")
  add(_t_fs, init_hand)
  
  add(_t_ids, "fork")
  add(_t_fs, init_fork)
  add(tools_to_draw, #_t_ids) 
  
  add(_t_ids, "shovel")
  add(_t_fs, init_shovel)
  add(tools_to_draw, #_t_ids) 
  
  add(_t_ids, "rake")
  add(_t_fs, init_rake)
  add(tools_to_draw, #_t_ids) 
  
  _t_init = {}
  for i=1, #_t_ids do
    _t_init[_t_ids[i]] = _t_fs[i]
  end
  
end

function init_player_tools(player)
  player.tools = {}
  
  for i=1, #_t_ids do
    add(player.tools, new_tool(_t_ids[i]))
  end
  
end

function new_tool(id, ...)
  log("gave player " .. id)
  return _t_init[id](id,...)
end

--
-- hand ---------------------
--

handable_types = {}

function init_hand(id)
  return {type = _t_ids[id], aoe_type = 1, effect = hand_base, to_draw = false}
end

function hand_base(gx, gy)

end







--
-- Fork ---------------------
--

forkable_types = {1}

function init_fork(id)
  return {type = _t_ids[id], aoe_type = 1, effect = fork_base, to_draw = true}
end

function fork_base(gx, gy)
  local g = ground
  local c = g.cells_t[gy][gx]
  
  if is_in(c.type, forkable_types) then
    c.type = 2
    spr_state[gy][gx] = 1
    update_tile_state(c, true)
  end

end

--
-- Shovel ---------------------
--

shovelable_types = {2, 3}

function init_shovel(id)
  return {type = _t_ids[id], aoe_type = 1, effect = shovel_base, to_draw = true}
end

function shovel_base(gx, gy)
  local g = ground
  local c = g.cells_t[gy][gx]
  
  if is_in(c.type, shovelable_types) then
    c.type = 1
    update_tile_state(c, true)
    spr_state[gy][gx] = 1
  end
  
end

--
-- Rake ---------------------
--

rakeable_types = {1}

function init_rake(id)
  return {type = _t_ids[id], aoe_type = 1, effect = rake_base, to_draw = true}
end

function rake_base(gx, gy)
  local g = ground
  local c = g.cells_t[gy][gx]
  
  if is_in(c.type, rakeable_types) then
    c.type = 3
    spr_state[gy][gx] = 1
    update_tile_state(c, true)
  end

end



















