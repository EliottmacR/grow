require('palette')
require('player')
require('u_i')
require('ground')
require('camera')
require('y_sort_draw')
require('tools/tools')

function init_game()

  init_ground()
  init_camera()
  init_ui()
  init_tools()
  init_player()
end

function update_game()
  update_player()
  update_camera()
end

function draw_game()
  cls(0)
  cam_on_player()
  draw_ground()
  y_sort_draw()
  camera()
  draw_ui()
  
end




