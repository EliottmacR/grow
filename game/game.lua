require('palette')
require('player')
require('ground')
require('camera')

function init_game()

  init_ground()
  init_camera()
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
  draw_player()
end




