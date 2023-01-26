hs.loadSpoon("RecursiveBinder")

spoon.RecursiveBinder.escapeKey = {{}, 'escape'}  -- Press escape to abort

local singleKey = spoon.RecursiveBinder.singleKey

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
  [singleKey('`', 'full')]       = function() setFocusedWindowPosition(0,   1,   0,   1) end,
  [singleKey('space', 'center')] = function() setFocusedWindowPosition(1/8, 7/8, 0,   1) end,
  [singleKey('a', 'left')]       = function() setFocusedWindowPosition(0,   0.5, 0,   1) end,
  [singleKey('s', 'bottom')]     = function() setFocusedWindowPosition(0,   1,   0.5, 1) end,
  [singleKey('d', 'top')]        = function() setFocusedWindowPosition(0,   1,   0,   0.5) end,
  [singleKey('f', 'right')]      = function() setFocusedWindowPosition(0.5, 1,   0,   1) end,
  [singleKey('q', 'top-left')]     = function() setFocusedWindowPosition(0,   0.5, 0,   0.5) end,
  [singleKey('r', 'top-right')]    = function() setFocusedWindowPosition(0.5, 1,   0,   0.5) end,
  [singleKey('z', 'bottom-left')]  = function() setFocusedWindowPosition(0,   0.5, 0.5, 1) end,
  [singleKey('v', 'bottom-right')] = function() setFocusedWindowPosition(0.5, 1,   0.5, 1) end,
}

hs.hotkey.bind({'shift'}, 'space', spoon.RecursiveBinder.recursiveBind(windowMoving))
