function love.conf(t)
	t.title = "Wikipedia Game"

	t.identity = "wikigame"
	t.console = true

	t.modules.window = true  
             -- The window height (number)
    t.window.borderless = false        -- Remove all border visuals from the window (boolean)
    t.window.resizable = true         -- Let the window be user-resizable (boolean)
    t.window.minwidth = 1              -- Minimum window width if the window is resizable (number)
    t.window.minheight = 1             -- Minimum window height if the window is resizable (number)
    t.window.fullscreen = false       -- Enable fullscreen (boolean)
    t.window.fullscreentype = "desktop" -- Standard fullscreen or desktop fullscreen mode (string)              -- Index of the monitor to show the window in (number)
    t.window.highdpi = true
end