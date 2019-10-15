require("game")  -- where all the fun happens
require("random_functions")
require("sugarcoat/sugarcoat")
sugar.utility.using_package(sugar.S, true)

if CASTLE_PREFETCH then
  CASTLE_PREFETCH({    
    "main.lua",
    "game.lua",    
})
end

--
-- Main  ------------------------------------------
--

function love.load()
  GW = 416  - 32 * 4 
  GH = GW * 2/3 
  zoom = 3
  time_since_launch = 0
  
  init_sugar("!Grow!", GW, GH, zoom )
  screen_render_integer_scale(false)    
  set_frame_waiting(30)
  init_controls()
  init_palette()
  use_palette(_sugar_palette)
  
  palt(0, true)  
  spr_s = load_png("spr_s", "assets/spr_s.png", nil, false)
  spritesheet (spr_s)
  spritesheet_grid (16,16)
  
  
  love.math.setRandomSeed(os.time())
  love.mouse.setVisible(true)
  init_game()
end

function love.update()
  time_since_launch = time_since_launch + dt()
  update_game()
end


function love.draw()
  draw_game()
end

--
-- Controls ------------------------------------------
--

function init_controls()
  register_btn("up"    , 0, {input_id("keyboard", "up")   ,
                             input_id("keyboard", "z")   })
                             
  register_btn("right"    , 0, {input_id("keyboard", "right")   ,
                                input_id("keyboard", "d")   })
                                
  register_btn("down"    , 0, {input_id("keyboard", "down")   ,
                               input_id("keyboard", "s")   })
                               
  register_btn("left"    , 0, {input_id("keyboard", "left"),
                               input_id("keyboard", "q")   })
                               
  ---------------------------------
  
  register_btn("action"    , 0, {input_id("keyboard", "f"),
                                 input_id("keyboard", "space") })
                                 
  register_btn("a"    , 0,  input_id("keyboard", "a"))
  register_btn("e"    , 0,  input_id("keyboard", "e"))
  
  -- register_btn("previous"    , 0, input_id("keyboard", "lalt"))
  register_btn("change_tool"    , 0, input_id("keyboard", "lshift"))
end













