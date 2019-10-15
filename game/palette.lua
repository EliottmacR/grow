
--
-- Palette ------------------------------------------
--

function init_palette()

  _sugar_palette = {}
  _palette = {}
  
  add_color(0x000000, "pblack"     )
  add_color(0x0f0f0f, "black"      )
  add_color(0xffffff, "pwhite"     )
  add_color(0xdfdfdf, "white"      )
  add_color(0x303035, "gray"       )
  add_color(0xff0000, "p_red"      )
  add_color(0x00ff00, "p_green"    )
  add_color(0x0000ff, "p_blue"     )
  add_color(0x450000, "d_red"      )
  add_color(0x004500, "d_green"    )
  add_color(0x000045, "d_blue"     )
  
  add_color(0xeb961c, "orange"     )
  add_color(0xa9961c, "slime_green")
  
  add_color(0x70b9c9, "turq_b")
  add_color(0x5e99a6, "sturq_b")
  
  add_color(0xd7e966, "dyellow")
  add_color(0x9eab4e, "ddyellow")
  
  add_color(0x274045, "dturq_b")
  add_color(0x1c2c30, "dsturq_b")
  
  add_color(0xc2a9ef, "mauve")
  add_color(0x927fb4, "smauve")
  
  add_color(0xa66c0e, "brown")
  add_color(0x89694c, "dbrown")
  
  add_color(0xbc804a, "wood")
  add_color(0x523608, "dwood")
  
  add_color(0x9b6a3f, "ldirt")
  
  add_color(0xa1db72, "lgreen")
  add_color(0x79a457, "slgreen")
  add_color(0x3c512b, "dlgreen")
  
  add_color(0xb3b3b3, "swhite")
  
  add_color(0x858585, "metal1")
  add_color(0x6e6e6e, "smetal1")
  add_color(0x454545, "dmetal1")
  
  
  
end

function add_color(value, name)
  add(_sugar_palette, value)
  add(_palette, name)
end

function _p_n(name)
	for i, c in pairs(_palette) do
		if c == name then return i-1 end
	end
end

function all_colors_to(c)
  if c then
    for i=0,#_palette do
      pal(i,c)
    end
  else
    for i=0,#_palette do
      pal(i,i)
    end
  end
end
