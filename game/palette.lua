
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
