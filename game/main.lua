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
  GW = 416*2 - 32 * 4 
  GH = GW * 2/3 
  zoom = 3
  init_sugar("!Grow!", GW, GH, zoom )
  screen_render_integer_scale(false)    
  set_frame_waiting(30)
  init_palette()
  use_palette(_sugar_palette)
  
  palt(0, true)  
  spr_s = load_png("spr_s", "assets/spr_s.png", nil, false)
  spritesheet (spr_s)
  spritesheet_grid (16,16)
  
  
  love.math.setRandomSeed(os.time())
  love.mouse.setVisible(true)
  
  init_game()
  init_controls()
end

function love.update()
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
                               
  register_btn("left"    , 0, {input_id("keyboard", "up"),
                               input_id("keyboard", "q")   })
end













