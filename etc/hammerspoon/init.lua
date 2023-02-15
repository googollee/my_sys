local setFocusedWindowPosition = function(left, right, top, bottom)
  local screen = hs.mouse.getCurrentScreen()
  local win = hs.window.focusedWindow()

  local f = win:frame()
  local max = screen:frame()

  f.x = max.w * left + max.x
  f.y = max.h * top + max.y
  f.w = max.w * right - f.x + max.x
  f.h = max.h * bottom - f.y + max.y

  win:move(f, screen)
end

local windowMoving = {
  [{'`', 'full'}]       = function() setFocusedWindowPosition(0,   1,   0,   1) end,
  [{'space', 'center'}] = function() setFocusedWindowPosition(1/8, 7/8, 0,   1) end,
  [{'a', 'left'}]       = function() setFocusedWindowPosition(0,   0.5, 0,   1) end,
  [{'s', 'bottom'}]     = function() setFocusedWindowPosition(0,   1,   0.5, 1) end,
  [{'d', 'top'}]        = function() setFocusedWindowPosition(0,   1,   0,   0.5) end,
  [{'f', 'right'}]      = function() setFocusedWindowPosition(0.5, 1,   0,   1) end,
  [{'q', 'top-left'}]     = function() setFocusedWindowPosition(0,   0.5, 0,   0.5) end,
  [{'r', 'top-right'}]    = function() setFocusedWindowPosition(0.5, 1,   0,   0.5) end,
  [{'z', 'bottom-left'}]  = function() setFocusedWindowPosition(0,   0.5, 0.5, 1) end,
  [{'v', 'bottom-right'}] = function() setFocusedWindowPosition(0.5, 1,   0.5, 1) end,
}

-- hs.loadSpoon("RecursiveBinder")
-- local singleKey = spoon.RecursiveBinder.singleKey

-- function toSingleKey(map)
  -- local ret = {}
  -- for key, f in pairs(map) do
    -- ret[singleKey(key[1], key[2])] = f
  -- end
  -- return ret
-- end

-- spoon.RecursiveBinder.escapeKey = {{}, 'escape'}  -- Press escape to abort
-- hs.hotkey.bind({'shift'}, 'space', spoon.RecursiveBinder.recursiveBind(toSingleKey(windowMoving)))

winModal = hs.hotkey.modal.new('shift', 'space')
winModal:bind('', 'escape', function() k:exit() end)
for key, f in pairs(windowMoving) do
  winModal:bind('', key[1], key[2], function()
    f()
    winModal:exit()
  end)
end
